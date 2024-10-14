resource "aws_iam_user" "iam_app" {
  name = var.iam_user_app
}

resource "aws_s3_bucket" "s3_bucket_app" {
  bucket = var.s3_bucket_app

  tags = {
    Name = var.s3_bucket_app
    Environment = "Staging"
  }
}

resource "aws_iam_policy" "iam_policy_app" {
  name = var.policy_name_app
  policy = data.aws_iam_policy_document.s3_policy_app.json
}

data "aws_iam_policy_document" "s3_policy_app" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      aws_s3_bucket.s3_bucket_app.arn,
      "${aws_s3_bucket.s3_bucket_app.arn}/*"
    ]
  }
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment_app" {
  user = aws_iam_user.iam_app.name
  policy_arn = aws_iam_policy.iam_policy_app.arn
}

resource "aws_iam_access_key" "my_access_key_app" {
  user = aws_iam_user.iam_app.name
}