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
- mkdir /data
- systemctl daemon-reload
- systemctl restart docker
