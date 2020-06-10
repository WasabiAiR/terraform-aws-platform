{
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:SetInstanceProtection",
                "ecs:DescribeClusters",
                "ecs:RegisterTaskDefinition",
                "ecs:RunTask",
                "logs:CreateExportTask",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeExportTasks",
                "logs:PutLogEvents",
                "rekognition:*",
                "s3:GetBucketLocation",
                "s3:ListAllMyBuckets",
                "ses:GetAccountSendingEnabled",
                "ses:GetIdentityVerificationAttributes"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        },
        {
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketPublicAccessBlock"
            ],
            "Effect": "Allow",
            "Resource": [
                "${aws_cust_labels_bucket_arn}",
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
                "${aws_cust_labels_bucket_arn}/*",
                "${file_storage_s3_bucket_arn}/*",
                "${usage_s3_bucket_arn}/*"
            ]
        },
        {
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Effect": "Allow",
            "Resource": [
                "${log_storage_s3_bucket_arn}/*"
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
        },
        {
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "${temporary_bucket_arn}"
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
                "${temporary_bucket_arn}/*"
            ]
        }
    ],
    "Version": "2012-10-17"
}
