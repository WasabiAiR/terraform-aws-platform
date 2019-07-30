#cloud-config
package_upgrade: false
runcmd:
- echo "proxy=http://${proxy_endpoint}" >> /etc/yum.conf
- mkdir -p /etc/systemd/system/docker.service.d
- echo "[Service]" > /etc/systemd/system/docker.service.d/http-proxy.conf
- echo "Environment=\"HTTP_PROXY=http://${proxy_endpoint}\" \"HTTPS_PROXY=http://${proxy_endpoint}\" \"NO_PROXY=localhost,127.0.0.1,169.254.169.254\"" >> /etc/systemd/system/docker.service.d/http-proxy.conf
- echo "HTTP_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
- echo "HTTPS_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
- echo "NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/ecs/ecs.config
- mkdir -p /etc/init/
- echo "env HTTP_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
- echo "env HTTPS_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
- echo "env NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/init/ecs.override
- echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
- yum install chrony -y
- systemctl enable chronyd
- systemctl start chronyd
- mkdir /data
- usermod -a -G docker graymeta
- systemctl daemon-reload
- systemctl restart docker
- systemctl enable gm-termprotector
- systemctl restart gm-termprotector
write_files:
-   content: |
        server 169.254.169.123 prefer iburst minpoll 4 maxpoll 4
        driftfile /var/lib/chrony/drift
        makestep 1.0 3
        rtcsync
        logdir /var/log/chrony
    path: /etc/chrony.conf
-   content: |
        AWS_REGION=${region}
        http_proxy=http://${proxy_endpoint}/
        https_proxy=http://${proxy_endpoint}/
        no_proxy=localhost,127.0.0.1,169.254.169.254
        termprotector_mode=docker
    path: /etc/graymeta/metafarm.env
    permissions: '0400'
    owner: graymeta:graymeta
