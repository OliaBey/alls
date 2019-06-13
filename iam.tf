locals {
  role_name = "${var.env_name}-nb-de-Role"
  role_profile = "${var.env_name}-nb-Profile"
  policy_name = "${var.env_name}-strict_to_S3-Policy"
}

resource "aws_iam_role" "nb_de_role" {
  name = "${local.role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com.cn"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    product = "${var.product}"
    Name = "${local.role_name}"
    environment_tag = "${var.env_name}"
  }
}

resource "aws_iam_instance_profile" "nb_profile" {
  name = "${local.role_profile}"
  role = "${aws_iam_role.nb_de_role.name}"
}

resource "aws_iam_policy" "strict_S3_policy" {
  name        = "${local.policy_name}"
  description = "Strict Bucket only policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:PutBucketPolicy",
                "s3:PutEncryptionConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::${var.env_name}*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:HeadObject"
            ],
            "Resource": "arn:aws:s3:::${var.env_name}-ssn-bucket/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:HeadObject",
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.env_name}-bucket/*",
                "arn:aws:s3:::${var.env_name}-shared-bucket/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "strict_S3_policy-attach" {
  role       = "${aws_iam_role.nb_de_role.name}"
  policy_arn = "${aws_iam_policy.strict_S3_policy.arn}"
}