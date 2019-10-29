{
    "Version": "2012-10-17",
    "Statement": [
       {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${graymeta_account}:root"
            },
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "${usage_s3_bucket_arn}",
                "${usage_s3_bucket_arn}/*"
            ]
       }
    ]
 }
