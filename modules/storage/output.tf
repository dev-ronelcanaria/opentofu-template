output "app_s3_bucket_prod" {
  value = aws_s3_bucket.s3_bucket_app
}

output "s3_bucket_policy_name" {
  value = aws_iam_policy.iam_policy_app
}

output "s3_access_key_id" {
  value = aws_iam_access_key.my_access_key_app.id
  description = "The access key ID for S3 access."
}

output "s3_secret_access_key" {
  value = aws_iam_access_key.my_access_key_app.secret
  sensitive = true
  description = "The secret access key for S3 access."
}

output "rds_db" {
  value = aws_db_instance.rds
}