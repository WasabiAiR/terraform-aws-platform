{
    "Statement": [
        {
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation",
                "logs:CreateLogGroup",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ecs:DescribeClusters",
                "ecs:RunTask",
                "ecs:RegisterTaskDefinition",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:SetInstanceProtection"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        },
        {
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "${file_storage_s3_bucket_arn}",
                "${usage_s3_bucket_arn}"
            ]
        },
        {
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "${file_storage_s3_bucket_arn}/*",
                "${usage_s3_bucket_arn}/*"
            ]
        },
        {
            "Action": [
                "sqs:*"
            ],
            "Effect": "Allow",
            "Resource": ["${sqs_queues}"]
        },
        {
            "Action": [
                "ses:SendEmail",
                "ses:SendRawEmail"
            ],
            "Condition": {
                "StringEquals": {
                    "ses:FromAddress": "${from_addr}"
                }
            },
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "sns:Publish"
            ],
            "Effect": "Allow",
            "Resource": [
                "${sns_topic_arn_harvest_complete}"
            ]
        }
    ],
    "Version": "2012-10-17"
}
