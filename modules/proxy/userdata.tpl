#cloud-config
package_upgrade: false
runcmd:
- yum update -y
- yum install -y cloud-utils-growpart
- growpart /dev/xvda 2
- growpart /dev/nvme0n1 2
- pvresize /dev/xvda2
- pvresize /dev/nvme0n1p2
- lvextend -l +100%FREE /dev/mapper/centos-root
- xfs_growfs /dev/mapper/centos-root
- yum install chrony -y
- systemctl enable chronyd
- systemctl start chronyd
- yum install squid -y
- systemctl enable squid
- systemctl start squid
- pip install --upgrade pip
- cd /tmp && wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py && python awslogs-agent-setup.py -n -r ${region} -c awslogs.conf
write_files:
- content: |
    [general]
    state_file = /var/awslogs/state/agent-state
    [/var/log/squid/access.log]
    file = /var/log/squid/access.log
    buffer_duration = 5000
    log_stream_name = access-{instance_id}
    initial_position = start_of_file
    log_group_name = ${log_group}
  path: /tmp/awslogs.conf
- content: |
    server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4
    driftfile /var/lib/chrony/drift
    makestep 1.0 3
    rtcsync
    logdir /var/log/chrony
  path: /etc/chrony.conf
- content: |
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
    acl SSL_ports port 443
    acl CONNECT method CONNECT
    http_access deny CONNECT !SSL_ports
    http_access allow localhost manager
    http_access deny manager
    http_access deny to_localhost
    acl osrepo dstdomain .dockerproject.org
    acl osrepo dstdomain .fedoraproject.org
    acl osrepo dstdomain .centos.org
    acl osrepo dstdomain .docker.io
    acl osrepo dstdomain .docker.com
    http_access allow osrepo
    acl platform dstdomain .${dns_name}
    http_access allow platform
    acl s3 dstdom_regex -i s3\..*\.amazonaws\.com
    http_access allow s3
    acl ecs dstdom_regex -i ecs.*\.amazonaws\.com
    http_access allow ecs
    acl logs dstdom_regex -i logs\..*\.amazonaws\.com
    http_access allow logs
    acl sqs dstdom_regex -i sqs\..*\.amazonaws\.com
    http_access allow sqs
    acl sns dstdom_regex -i sns\..*\.amazonaws\.com
    http_access allow sns
    acl cogs dstdomain "/etc/squid/gm-cogs.conf"
    http_access allow cogs
    http_access allow localhost
    http_access deny all
    http_port 3128
    cache deny all
    coredump_dir /var/spool/squid
  path: /etc/squid/squid.conf
- path: /etc/squid/gm-cogs.conf
  content: |
${safelist}
