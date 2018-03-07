#cloud-config
package_upgrade: false
runcmd:
- echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
- yum install -y nfs-utils
- mkdir /data
- echo "$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone).${file_system_id}.efs.${region}.amazonaws.com:/    /data   nfs    defaults,vers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0" >> /etc/fstab
- mount -a
- service docker restart
- start ecs
