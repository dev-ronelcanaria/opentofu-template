resource "aws_iam_role" "observability_role" {
  name = "observability-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
          Effect = "Allow",
          Principal = {
          Service = "ec2.amazonaws.com"
          },
          Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "observability_policy" {
  name = "observability-policy"
  description = "Policy for Observability EC2 service discovery"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
    {
        Effect = "Allow",
        Action = [
        "ec2:DescribeInstances",
        "ec2:DescribeTags"
        ],
        Resource = "*"
    }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "observability_role_policy" {
  role = aws_iam_role.observability_role.name
  policy_arn = aws_iam_policy.observability_policy.arn
}

resource "aws_iam_instance_profile" "observability_instance_profile" {
  name = "observability-instance-profile"
  role = aws_iam_role.observability_role.name
}