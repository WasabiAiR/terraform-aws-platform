#!/bin/bash

cat <<PROXY > /etc/profile.d/proxy.sh 
export HTTP_PROXY=http://${proxy_endpoint}/
export HTTPS_PROXY=http://${proxy_endpoint}/
export NO_PROXY=169.254.169.254,localhost,127.0.0.1
PROXY
source /etc/profile.d/proxy.sh


grep -q "proxy=" /etc/yum.conf
if [ $? -ne 0 ]; then
  echo "# Updating Yum Proxy"
  echo "proxy=http://${proxy_endpoint}" >> /etc/yum.conf
fi 
sed -i 's/^metalink=/#metalink=/g' /etc/yum.repos.d/*
sed -i 's/^mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/*
sed -i 's/^#baseurl=/baseurl=/g' /etc/yum.repos.d/*
sed -i 's/download.fedoraproject.org/dl.fedoraproject.org/g' /etc/yum.repos.d/epel*

yum install -y \
  cloud-utils-growpart \
  chrony \
  docker \
  graphite-web \
  lvm2 \
  python-carbon \
  python-whisper

systemctl enable chronyd
systemctl start chronyd

RDEV=`df -P / | awk 'END{print $1}' | tr -d '\n'`
echo "# Growing Root Parition: $RDEV"
if [ -z "$RDEV" ]; then
  echo "ERR: Unable to find Root Device"
else
  if [[ "$RDEV" =~ ^/dev/mapper ]]; then
    LDEV=$(pvs -o pv_name --noheadings -S lv_dm_path=$RDEV | awk {'print $1'})
    DISK=`echo $LDEV | sed 's/.$//'`
    PART=`echo -n $LDEV | tail -c 1`
    growpart $DISK $PART
    pvresize $LDEV
    lvextend -l 100%FREE $RDEV
    xfs_growfs $RDEV
  elif [[ "$RDEV" =~ ^/dev/nvme ]]; then
    DISK=`echo $RDEV | awk -Fp {'print $1'}`
    PART=`echo $RDEV | awk -Fp {'print $2'}`
    growpart $DISK $PART
    xfs_growfs $RDEV
  else
    DISK=`echo $RDEV | sed 's/.$//'`
    PART=`echo -n $RDEV | tail -c 1`
    growpart $DISK $PART
    xfs_growfs $RDEV
  fi
fi

mkdir -p /etc/systemd/system/docker.service.d
if [ ! -f /etc/systemd/system/docker.service.d/http-proxy.conf ]; then
  cat <<DOCKER > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment=HTTP_PROXY=http://${proxy_endpoint}
Environment=HTTPS_PROXY=http://${proxy_endpoint}
Environment=NO_PROXY=localhost,127.0.0.1,169.254.169.254
DOCKER
fi

mkdir -p /data/graphite/conf
mkdir -p /data/graphite/storage
mkdir -p /data/statsd/config

cat << SCHEMA > /data/graphite/conf/storage-schemas.conf
[carbon]
pattern = ^carbon\.
retentions = 60s:90d

[timers]
pattern = ^statsite\.timers\.
retentions = 60s:15d,1800s:365d

[default]
pattern = .*
retentions = 60s:30d,300s:365d
SCHEMA

cat << STORAGG > /data/graphite/conf/storage-aggregation.conf 
[min]
pattern = \.min$
xFilesFactor = 0.1
aggregationMethod = min

[max]
pattern = \.max$
xFilesFactor = 0.1
aggregationMethod = max

[sum]
pattern = \.count$
xFilesFactor = 0
aggregationMethod = sum

[default_average]
pattern = .*
xFilesFactor = 0.5
aggregationMethod = average
STORAGG

cat << CARBONCONF > /data/graphite/conf/carbon.conf
[cache]
CACHE_QUERY_INTERFACE = 0.0.0.0
CACHE_QUERY_PORT = 7002
CACHE_WRITE_STRATEGY = sorted
CARBON_METRIC_INTERVAL = 10
DATABASE = whisper
ENABLE_LOGROTATION = True
ENABLE_UDP_LISTENER = False
GRAPHITE_URL = http://127.0.0.1:8080
LINE_RECEIVER_INTERFACE = 0.0.0.0
LINE_RECEIVER_PORT = 2003
LOG_CACHE_HITS = False
LOG_CACHE_QUEUE_SORTS = False
LOG_CREATES = False
LOG_UPDATES = False
MAX_CACHE_SIZE = inf
MAX_CREATES_PER_MINUTE = 50
MAX_UPDATES_PER_SECOND = 500
MIN_TIMESTAMP_RESOLUTION = 1
PICKLE_RECEIVER_INTERFACE = 0.0.0.0
PICKLE_RECEIVER_PORT = 2004
UDP_RECEIVER_INTERFACE = 0.0.0.0
UDP_RECEIVER_PORT = 2003
USER =
USE_FLOW_CONTROL = True
USE_INSECURE_UNPICKLER = False
WHISPER_AUTOFLUSH = False
WHISPER_FALLOCATE_CREATE = True

[relay]
LINE_RECEIVER_INTERFACE = 0.0.0.0
LINE_RECEIVER_PORT = 2013
PICKLE_RECEIVER_INTERFACE = 0.0.0.0
PICKLE_RECEIVER_PORT = 2014
LOG_LISTENER_CONNECTIONS = True
RELAY_METHOD = rules
REPLICATION_FACTOR = 1
DESTINATIONS = 127.0.0.1:2004
MAX_DATAPOINTS_PER_MESSAGE = 500
MAX_QUEUE_SIZE = 10000
QUEUE_LOW_WATERMARK_PCT = 0.8
USE_FLOW_CONTROL = True

[aggregator]
LINE_RECEIVER_INTERFACE = 0.0.0.0
LINE_RECEIVER_PORT = 2023
PICKLE_RECEIVER_INTERFACE = 0.0.0.0
PICKLE_RECEIVER_PORT = 2024
LOG_LISTENER_CONNECTIONS = True
FORWARD_ALL = False
DESTINATIONS = 127.0.0.1:2004
REPLICATION_FACTOR = 1
MAX_QUEUE_SIZE = 10000
USE_FLOW_CONTROL = True
MAX_DATAPOINTS_PER_MESSAGE = 500
MAX_AGGREGATION_INTERVALS = 5
CARBONCONF


cat << GRAPHITE > /etc/systemd/system/docker-graphite.service
[Unit]
Description=Daemon for graphite
After=docker.service
Wants=
Requires=docker.service
[Service]
Restart=on-failure
StartLimitInterval=20
StartLimitBurst=5
TimeoutStartSec=0
Environment="HOME=/root"
ExecStartPre=-/usr/bin/docker kill graphite
ExecStartPre=-/usr/bin/docker rm  graphite
ExecStart=/usr/bin/docker run \
  -v /data/graphite/conf:/opt/graphite/conf \
  -v /data/graphite/storage:/opt/graphite/storage \
  -p 8080:80 \
  -p 2003-2004:2003-2004 \
  -p 2023-2024:2023-2024 \
  -e "CARBON_AGGREGATOR_DISABLED=1" \
  -e "STATSD_DISABLED=1" \
  -e "RELAY=1" \
  --name graphite \
  graphiteapp/graphite-statsd

ExecStop=-/usr/bin/docker stop --time=0 graphite
ExecStop=-/usr/bin/docker rm graphite
[Install]
WantedBy=multi-user.target
GRAPHITE
chmod 0644 /etc/systemd/system/docker-graphite.service

cat << STATSITE > /etc/systemd/system/docker-statsite.service
[Unit]
Description=Daemon for statsite
After=docker.service
Wants=
Requires=docker.service
[Service]
Restart=on-failure
StartLimitInterval=20
StartLimitBurst=5
TimeoutStartSec=0
Environment="HOME=/root"
ExecStartPre=-/usr/bin/docker kill statsite
ExecStartPre=-/usr/bin/docker rm  statsite
ExecStart=/usr/bin/docker run \
  -p 8125:8125 \
  -p 8125:8125/udp \
  -e "STATSITE_FLUSH_INTERVAL=60" \
  -e "GRAPHITE_SERVER=172.17.0.1" \
  -e "GRAPHITE_PORT=2003" \
  --name statsite \
  sohonet/statsite:v0.0.2

ExecStop=-/usr/bin/docker stop --time=0 statsite
ExecStop=-/usr/bin/docker rm statsite
[Install]
WantedBy=multi-user.target
STATSITE
chmod 0644 /etc/systemd/system/docker-statsite.service

systemctl daemon-reload
systemctl enable docker
systemctl start docker
systemctl enable docker-graphite
systemctl start docker-graphite
systemctl enable docker-statsite
systemctl start docker-statsite