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
- systemctl enable docker-faces-data.service
- systemctl restart docker-faces-data.service
- systemctl enable docker-faces-api.service
- systemctl restart docker-faces-api.service
- systemctl enable docker-faces-tfs.service
- systemctl restart docker-faces-tfs.service
- systemctl enable docker-credits-api.service
- systemctl restart docker-credits-api.service
- systemctl enable docker-credits-tfs.service
- systemctl restart docker-credits-tfs.service
- systemctl enable docker-slates-api.service
- systemctl restart docker-slates-api.service
- systemctl enable docker-slates-tfs.service
- systemctl restart docker-slates-tfs.service
write_files:
-   content: |
        [Unit]
        Description=Daemon for faces-data
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill faces-data
        ExecStartPre=-/usr/bin/docker rm faces-data
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "GMFACES_DBCFG_HOST=${postgresendpoint}" \
            -e "GMFACES_DBCFG_PORT=${postgresport}" \
            -e "GMFACES_DBCFG_DBUSER=${postgresuser}" \
            -e "GMFACES_DBCFG_PASSWORD=${postgrespass}" \
            -e "GMFACES_DBCFG_NAME=${postgresdb}" \
            -p 10333:10333 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name faces-data \
            graymeta-faces-data
        ExecStop=-/usr/bin/docker stop --time=0 faces-data
        ExecStop=-/usr/bin/docker rm faces-data
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-faces-data.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for faces-api
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill faces-api
        ExecStartPre=-/usr/bin/docker rm  faces-api
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "GMFACES_DATA_HOST=172.17.0.1" \
            -e "GMFACES_DATA_PORT=10333" \
            -e "GMFACES_DATA_VERSION=${dataversion}" \
            -e "GMFACES_TFS_HOST=172.17.0.1" \
            -e "GMFACES_TFS_PORT=11333" \
            -e "GMFACES_LOG_LEVEL=INFO" \
            -p 10336:10336 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name faces-api \
            graymeta-faces-api
        ExecStop=-/usr/bin/docker stop --time=0 faces-api
        ExecStop=-/usr/bin/docker rm faces-api
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-faces-api.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for faces-tfs
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill faces-tfs
        ExecStartPre=-/usr/bin/docker rm  faces-tfs
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -p 11333:9000 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name faces-tfs \
            graymeta-faces-tfs
        ExecStop=-/usr/bin/docker stop --time=0 faces-tfs
        ExecStop=-/usr/bin/docker rm faces-tfs
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-faces-tfs.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for credits-api
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill credits-api
        ExecStartPre=-/usr/bin/docker rm  credits-api
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "FLASK_API_PORT=10337" \
            -e "TFS_HOST=172.17.0.1" \
            -e "TFS_PORT=11337" \
            -p 10337:10337 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name credits-api \
            graymeta-credits-api
        ExecStop=-/usr/bin/docker stop --time=0 credits-api
        ExecStop=-/usr/bin/docker rm credits-api
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-credits-api.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for credits-tfs
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill credits-tfs
        ExecStartPre=-/usr/bin/docker rm  credits-tfs
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -p 11337:9000 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name credits-tfs \
            graymeta-credits-tfs
        ExecStop=-/usr/bin/docker stop --time=0 credits-tfs
        ExecStop=-/usr/bin/docker rm credits-tfs
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-credits-tfs.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for slates-api
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill slates-api
        ExecStartPre=-/usr/bin/docker rm  slates-api
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "FLASK_API_PORT=10338" \
            -e "TFS_HOST=172.17.0.1" \
            -e "TFS_PORT=11338" \
            -p 10338:10338 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name slates-api \
            graymeta-slates-api
        ExecStop=-/usr/bin/docker stop --time=0 slates-api
        ExecStop=-/usr/bin/docker rm slates-api
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-slates-api.service
    permissions: '0644'
-   content: |
        [Unit]
        Description=Daemon for slates-tfs
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill slates-tfs
        ExecStartPre=-/usr/bin/docker rm  slates-tfs
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -p 11338:9000 \
            --log-driver=awslogs \
            --log-opt awslogs-group=${log_group} \
            --name slates-tfs \
            graymeta-slates-tfs
        ExecStop=-/usr/bin/docker stop --time=0 slates-tfs
        ExecStop=-/usr/bin/docker rm slates-tfs
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-slates-tfs.service
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
