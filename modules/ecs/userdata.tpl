#cloud-config
package_upgrade: false
runcmd:
- echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
- mkdir /data
- service docker restart
- start ecs
