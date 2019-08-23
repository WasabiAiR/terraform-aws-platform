#cloud-config
package_upgrade: false
output: { all : '| tee -a /var/log/cloud-init-output.log' }
