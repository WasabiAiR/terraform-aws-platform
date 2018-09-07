#cloud-config
package_upgrade: false
runcmd:
- yum install -y cloud-utils-growpart
- growpart /dev/xvda 2
- growpart /dev/nvme0n1 2
- pvresize /dev/xvda2
- pvresize /dev/nvme0n1p2
- lvextend -l +100%FREE /dev/mapper/centos-root
- xfs_growfs /dev/mapper/centos-root
- systemctl daemon-reload
- systemctl enable docker-faces-data.service
- systemctl restart docker-faces-data.service
- systemctl enable docker-faces.service
- systemctl restart docker-faces.service
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
        ExecStartPre=-/usr/bin/docker kill face-data
        ExecStartPre=-/usr/bin/docker rm  face-data
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "GMFACES_DBCFG_HOST=${postgresendpoint}" \
            -e "GMFACES_DBCFG_PORT=${postgresport}" \
            -e "GMFACES_DBCFG_DBUSER=${postgresuser}" \
            -e "GMFACES_DBCFG_PASSWORD=${postgrespass}" \
            -e "GMFACES_DBCFG_NAME=${postgresdb}" \
            -p 10333:10333 \
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
        Description=Daemon for faces
        After=docker.service
        Wants=
        Requires=docker.service
        [Service]
        Restart=on-failure
        StartLimitInterval=20
        StartLimitBurst=5
        TimeoutStartSec=0
        Environment="HOME=/root"
        ExecStartPre=-/usr/bin/docker kill faces
        ExecStartPre=-/usr/bin/docker rm  faces
        ExecStart=/usr/bin/docker run \
            --net bridge \
            -m 0b \
            -e "GMFACES_DATA_HOST=172.17.0.1" \
            -e "GMFACES_DATA_PORT=10333" \
            -e "GMFACES_DATA_VERSION=${dataversion}" \
            -p 10336:10336 \
            --name faces \
            graymeta-faces
        ExecStop=-/usr/bin/docker stop --time=0 faces
        ExecStop=-/usr/bin/docker rm faces
        [Install]
        WantedBy=multi-user.target
    path: /etc/systemd/system/docker-faces.service
    permissions: '0644'
