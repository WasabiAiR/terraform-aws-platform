#cloud-config
package_upgrade: false
runcmd:
- echo "export HTTP_PROXY=http://${proxy_endpoint}/" >> /etc/profile.d/proxy.sh
- echo "export HTTPS_PROXY=http://${proxy_endpoint}/" >> /etc/profile.d/proxy.sh
- echo "export NO_PROXY=169.254.169.254,localhost,127.0.0.1,/var/run/docker.sock" >> /etc/profile.d/proxy.sh
- source /etc/profile.d/proxy.sh
- echo "proxy=http://${proxy_endpoint}" >> /etc/yum.conf
- sed -i 's/^metalink=/#metalink=/g' /etc/yum.repos.d/*
- sed -i 's/^mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/*
- sed -i 's/^#baseurl=/baseurl=/g' /etc/yum.repos.d/*
- yum install -y cloud-utils-growpart
- growpart /dev/xvda 2
- growpart /dev/nvme0n1 2
- pvresize /dev/xvda2
- pvresize /dev/nvme0n1p2
- lvextend -l +100%FREE /dev/mapper/centos-root
- xfs_growfs /dev/mapper/centos-root
- systemctl daemon-reload
- systemctl restart docker
- systemctl enable docker-${service_name}-data.service
- systemctl restart docker-${service_name}-data.service
- systemctl enable docker-${service_name}-api.service
- systemctl restart docker-${service_name}-api.service
- systemctl enable docker-${service_name}-tfs.service
- systemctl restart docker-${service_name}-tfs.service
write_files:
-   content: |
        [Unit]
        Description=Daemon for ${service_name}-data
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill ${service_name}-data
        ExecStartPre=-/usr/bin/docker rm ${service_name}-data
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "GMFACES_DBCFG_HOST=${postgresendpoint}" \
            -e "GMFACES_DBCFG_PORT=${postgresport}" \
            -e "GMFACES_DBCFG_DBUSER=${postgresuser}" \
            -e "GMFACES_DBCFG_PASSWORD=${postgrespass}" \
            -e "GMFACES_DBCFG_NAME=${postgresdb}" \
            -p ${data_port}:10333 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name ${service_name}-data \
            graymeta-${service_name}-data
        ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-data
        ExecStop=-/usr/bin/docker rm ${service_name}-data
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-${service_name}-data.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for ${service_name}-api
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill ${service_name}-api
        ExecStartPre=-/usr/bin/docker rm  ${service_name}-api
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "DATA_HOST=172.17.0.1" \
            -e "DATA_PORT=${data_port}" \
            -e "DATA_VERSION=${dataversion}" \
            -e "FLASK_API_PORT=10336" \
            -e "TFS_HOST=172.17.0.1" \
            -e "TFS_PORT=${tfs_port}" \
            -e "LOG_LEVEL=INFO" \
            -e "CELEB_DATASET=/data/msceleb/" \
            -p ${api_port}:10336 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name ${service_name}-api \
            graymeta-${service_name}-api
        ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-api
        ExecStop=-/usr/bin/docker rm ${service_name}-api
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-${service_name}-api.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for ${service_name}-tfs
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill ${service_name}-tfs
        ExecStartPre=-/usr/bin/docker rm  ${service_name}-tfs
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -p ${tfs_port}:9000 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name ${service_name}-tfs \
            graymeta-${service_name}-tfs
        ExecStop=-/usr/bin/docker stop --time=0 ${service_name}-tfs
        ExecStop=-/usr/bin/docker rm ${service_name}-tfs
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-${service_name}-tfs.service
    permissions: '0644'
-   content: |
        [Service]
        Environment="HTTP_PROXY=http://${proxy_endpoint}" "HTTPS_PROXY=https://${proxy_endpoint}" "NO_PROXY=169.254.169.254,localhost,127.0.0.1,/var/run/docker.sock"
    path: /etc/systemd/system/docker.service.d/http-proxy.conf
    permissions: '0644'
-   content: |
        HTTP_PROXY=http://${proxy_endpoint}
        HTTPS_PROXY=https://${proxy_endpoint}
        NO_PROXY=169.254.169.254
    path: /var/awslogs/etc/proxy.conf
