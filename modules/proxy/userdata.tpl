#cloud-config
package_upgrade: false
runcmd:
- docker rmi $(docker images -q)
- systemctl stop docker
- systemctl disable docker
- yum install -y cloud-utils-growpart
- growpart /dev/xvda 2
- growpart /dev/nvme0n1 2
- pvresize /dev/xvda2
- pvresize /dev/nvme0n1p2
- lvextend -l +100%FREE /dev/mapper/centos-root
- xfs_growfs /dev/mapper/centos-root
- yum install squid -y
- systemctl enable squid
- systemctl start squid
- pip install --upgrade pip
- cd /tmp && wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py && python awslogs-agent-setup.py -n -r ${region} -c awslogs.conf
write_files:
  - path: /tmp/awslogs.conf
    content: |
      [general]
      state_file = /var/awslogs/state/agent-state
      [/var/log/squid/access.log]
      file = /var/log/squid/access.log
      buffer_duration = 5000
      log_stream_name = access-{instance_id}
      initial_position = start_of_file
      log_group_name = ${log_group}
  - path: /etc/squid/squid.conf
    content: |
      # Deny requests to certain unsafe ports
      acl Safe_ports port 80          # http
      acl Safe_ports port 21          # ftp
      acl Safe_ports port 443         # https
      acl Safe_ports port 70          # gopher
      acl Safe_ports port 210         # wais
      acl Safe_ports port 1025-65535  # unregistered ports
      acl Safe_ports port 280         # http-mgmt
      acl Safe_ports port 488         # gss-http
      acl Safe_ports port 591         # filemaker
      acl Safe_ports port 777         # multiling http
      http_access deny !Safe_ports
      
      # Deny CONNECT to other than secure SSL ports
      acl SSL_ports port 443
      acl CONNECT method CONNECT
      http_access deny CONNECT !SSL_ports

      # Only allow cachemgr access from localhost
      http_access allow localhost manager
      http_access deny manager
      http_access deny to_localhost

      # Graymeta Rules
      acl osyum dstdomain .dockerproject.org
      acl osyum dstdomain .fedoraproject.org
      acl osyum dstdomain .centos.org
      http_access allow osyum

      acl docker dstdomain .docker.io
      http_access allow docker

      acl platform dstdomain .${dns_name}
      http_access allow platform

      acl aws dstdomain .amazonaws.com
      http_access allow aws

      acl cogs dstdomain .darksky.net
      acl cogs dstdomain .kairos.com
      acl cogs dstdomain .googleapis.com
      acl cogs dstdomain .cognitive.microsoft.com
      acl cogs dstdomain .watsonplatform.net
      acl cogs dstdomain .apptek.graymeta.com
      acl cogs dstdomain .voicebase.com
      http_access allow cogs

      # Remove this once identify all sites need access
      # acl localnet src 10.0.0.0/8     # RFC1918 possible internal network
      # acl localnet src 172.16.0.0/12  # RFC1918 possible internal network
      # acl localnet src 192.168.0.0/16 # RFC1918 possible internal network
      # acl localnet src fc00::/7       # RFC 4193 local private network range
      # acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines
      # http_access allow localnet

      # Allow the proxy server out
      http_access allow localhost

      # And finally deny all other
      http_access deny all

      # Squid normally listens to port 3128
      http_port 3128

      # Uncomment and adjust the following to add a disk cache directory.
      #cache_dir ufs /var/spool/squid 100 16 256

      # Leave coredumps in the first cache dir
      coredump_dir /var/spool/squid

      #
      # Add any of your own refresh_pattern entries above these.
      #
      refresh_pattern ^ftp:           1440    20%     10080
      refresh_pattern ^gopher:        1440    0%      1440
      refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
      refresh_pattern .               0       20%     4320