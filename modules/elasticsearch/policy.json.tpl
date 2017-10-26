{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${region}:${account_id}:domain/graymeta-${platform_instance_id}/*",
            "Condition": {
                "IpAddress": {"aws:SourceIp": ["${source_ip}"]}
            }
        }
    ]
}
