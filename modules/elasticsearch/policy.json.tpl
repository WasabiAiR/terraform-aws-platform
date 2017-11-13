{
    "Statement": [
        {
            "Action": [
                "es:*"
            ],
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "*"
                ]
            },
            "Resource": "arn:aws:es:${region}:${account_id}:domain/${domain_name}/*"
        }
    ],
    "Version": "2012-10-17"
}
