#cloud-config
package_upgrade: false
runcmd:
- echo "export HTTP_PROXY=http://${proxy_endpoint}/" >> /etc/profile.d/proxy.sh
- echo "export HTTPS_PROXY=http://${proxy_endpoint}/" >> /etc/profile.d/proxy.sh
- echo "export NO_PROXY=169.254.169.254,localhost,127.0.0.1,s3.${region}.amazonaws.com,*.s3.${region}.amazonaws.com,$(echo ${elasticsearch_endpoint} |sed 's/https\?:\/\///'),${mlservices_endpoint}" >> /etc/profile.d/proxy.sh
- source /etc/profile.d/proxy.sh
- echo "proxy=http://${proxy_endpoint}" >> /etc/yum.conf
- sed -i 's/^metalink=/#metalink=/g' /etc/yum.repos.d/*
- sed -i 's/^mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/*
- sed -i 's/^#baseurl=/baseurl=/g' /etc/yum.repos.d/*
- sed -i 's/download.fedoraproject.org/dl.fedoraproject.org/g' /etc/yum.repos.d/epel*
- yum remove -y docker-engine docker-engine-selinux
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
- sed -i 's/^log_group_name = .*/log_group_name = ${services_log_group}/' /var/awslogs/etc/awslogs.conf
- systemctl restart awslogs
- sed 's/^export //g' < /etc/profile.d/proxy.sh  >> /etc/graymeta/metafarm.env
- /opt/graymeta/bin/aws_configurator -bucket ${file_storage_s3_bucket_arn} -usage-bucket ${usage_s3_bucket_arn} -region ${region} -encrypted-config-blob "${encrypted_config_blob}" >> /etc/graymeta/metafarm.env 2>/var/log/graymeta/aws_configurator.log
- systemctl daemon-reload
- /opt/graymeta/bin/all-services.sh restart
- /opt/graymeta/bin/all-services.sh enable
- systemctl enable gm-termprotector.service
- systemctl restart gm-termprotector.service
- echo "net.ipv4.tcp_fin_timeout = 1" >> /etc/sysctl.conf
- echo "net.ipv4.tcp_keepalive_intvl = 20" >> /etc/sysctl.conf
- echo "net.ipv4.tcp_keepalive_probes = 5" >> /etc/sysctl.conf
- sysctl -p
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
        PATH=/opt/graymeta/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
        SES_REGION=${from_region}
        account_lockout_attempts=${account_lockout_attempts}
        account_lockout_interval=${account_lockout_interval}
        account_lockout_period=${account_lockout_period}
        bcrypt_cost=${bcrypt_cost}
        box_com_client_id=${box_com_client_id}
        box_com_secret_key=${box_com_secret_key}
        dropbox_app_key=${dropbox_app_key}
        dropbox_app_secret=${dropbox_app_secret}
        external_data_api=https://${dns_name}/api/data
        external_file_api=https://${dns_name}/files
        external_scheduler_api=https://${dns_name}/api/scheduler
        external_usage_api=https://${dns_name}/api/usage
        gm_auth_api_redis_key_prefix="authapi:"
        gm_base_url=https://${dns_name}
        gm_celeb_detection_aws_region=${region}
        gm_celeb_detection_enabled=${gm_celeb_detection_enabled}
        gm_celeb_detection_interval=${gm_celeb_detection_interval}
        gm_celeb_detection_min_confidence=${gm_celeb_detection_min_confidence}
        gm_celeb_detection_provider=${gm_celeb_detection_provider}
        gm_completed_sns_topic_arn=${sns_topic_arn_harvest_complete}
        gm_container_image=graymeta/harvester
        gm_db_host=${db_endpoint}
        gm_db_name=graymeta
        gm_db_password=${db_password}
        gm_db_port=5432
        gm_db_username=${db_username}
        gm_ecs_cluster=${ecs_cluster}
        gm_ecs_cpu=${ecs_cpu_reservation}
        gm_ecs_log_group=${ecs_log_group}
        gm_ecs_memory_hard=${ecs_memory_hard_reservation}
        gm_ecs_memory_soft=${ecs_memory_soft_reservation}
        gm_ecs_region=${region}
        gm_elasticsearch=${elasticsearch_endpoint}
        gm_email_from=${from_addr}
        gm_email_sender=ses
        gm_encryption_key=${encryption_key}
        gm_enforce_default_password=false
        gm_env=${gm_env}
        gm_es_bulk_size=${gm_es_bulk_size}
        gm_es_bulk_workers=${gm_es_bulk_workers}
        gm_faces_recog_api_addr=http://${faces_endpoint}
        gm_fileapi_stow_kind=s3
        gm_front_end_client_secret=${client_secret_fe}
        gm_harvest_complete_stow_fields=${harvest_complete_stow_fields}
        gm_harvest_polling_time=${harvest_polling_time}
        gm_internal_client_secret=${client_secret_internal}
        gm_job_status_api=https://${dns_name}/api/jobstatus
        gm_job_store_redis_key_prefix="jobinfo:"
        gm_jwt_expiration_time=${gm_jwt_expiration_time}
        gm_jwt_private_key=${jwt_key}
        gm_license_key=${gm_license_key}
        gm_recently_walked_expiration=1209600s
        gm_recently_walked_redis_key_prefix="recwalked:"
        gm_redis=${elasticache_services}:6379
        gm_redis_db=0
        gm_roles_key_prefix="roles:"
        gm_user_key_prefix="user:"
        gm_user_apikey_prefix="apikey:"
        gm_sqs_activity=${sqs_activity}
        gm_sqs_index=${sqs_index}
        gm_sqs_itemcleanup=${sqs_itemcleanup}
        gm_sqs_notifications=${sqs_notifications}
        gm_sqs_stage=${sqs_stage}
        gm_sqs_walk=${sqs_walk}
        gm_threshold_to_harvest=${gm_threshold_to_harvest}
        gm_usage_prefix=${gm_usage_prefix}
        gm_usageapi_stow_kind=s3
        gm_walkd_max_item_concurrency=${gm_walkd_max_item_concurrency}
        gm_walkd_redis_max_active=${gm_walkd_redis_max_active}
        google_maps_key=${google_maps_key}
        harvest_gm_faces_recog_api_addr=http://${faces_endpoint}
        harvest_gm_temp_bucket_name=${temporary_bucket_name}
        harvest_gm_temp_bucket_region=${region}
        harvest_magic_files=/etc/magic:/usr/share/misc/magic:/etc/graymeta/mime.magic
        harvest_rollbar_token=${rollbar_token}
        indexer_client_timeout=5m
        oauthconnect_encryption_key=${oauthconnect_encryption_key}
        oauthconnect_url=https://${dns_name}:8443/connect
        password_min_length=${password_min_length}
        rollbar_token=${rollbar_token}
        s3subscriber_priority=${s3subscriber_priority}
        saml_attr_email=${saml_attr_email}
        saml_attr_firstname=${saml_attr_firstname}
        saml_attr_lastname=${saml_attr_lastname}
        saml_attr_uid=${saml_attr_uid}
        saml_cert=${saml_cert}
        saml_idp_metadata_url=${saml_idp_metadata_url}
        saml_key=${saml_key}
        segment_write_key=${segment_write_key}
        statsd_host=${statsd_host}
        stow_mountpath=/var/lib/graymeta/mounts
        walkd_item_batch_size=${walkd_item_batch_size}
        http_proxy=http://${proxy_endpoint}/
        https_proxy=http://${proxy_endpoint}/
        no_proxy=localhost,127.0.0.1,169.254.169.254,s3.${region}.amazonaws.com,*.s3.${region}.amazonaws.com,$(echo ${elasticsearch_endpoint} |sed 's/https\?:\/\///'),${mlservices_endpoint}
        harvest_http_proxy=http://${proxy_endpoint}/
        harvest_https_proxy=http://${proxy_endpoint}/
        harvest_no_proxy=169.254.169.254,169.254.170.2,/var/run/docker.sock,${mlservices_endpoint}
    path: /etc/graymeta/metafarm.env
    permissions: '0400'
    owner: graymeta:graymeta
-   content: |
        [plugins]
        cwlogs = cwlogs
        [default]
        region = ${region}
    path: /var/awslogs/etc/aws.conf
-   content: |
        HTTP_PROXY=http://${proxy_endpoint}
        HTTPS_PROXY=https://${proxy_endpoint}
        NO_PROXY=169.254.169.254
    path: /var/awslogs/etc/proxy.conf
