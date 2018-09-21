#cloud-config
package_upgrade: false
runcmd:
- echo "proxy=http://${proxy_endpoint}" >> /etc/yum.conf
- echo "export HTTP_PROXY=http://${proxy_endpoint}" >> /etc/sysconfig/docker
- echo "export HTTPS_PROXY=http://${proxy_endpoint}" >> /etc/sysconfig/docker
- echo "export NO_PROXY=169.254.169.254" >> /etc/sysconfig/docker
- echo "HTTP_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
- echo "HTTPS_PROXY=http://${proxy_endpoint}" >> /etc/ecs/ecs.config
- echo "NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/ecs/ecs.config
- echo "env HTTP_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
- echo "env HTTPS_PROXY=${proxy_endpoint}" >> /etc/init/ecs.override
- echo "env NO_PROXY=169.254.169.254,169.254.170.2,/var/run/docker.sock" >> /etc/init/ecs.override
- echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
- mkdir /data
- service docker restart
- start ecs
