# S3 bucket (data lake) name
output "s3_bucket_name" {
  description = "S3 bucket name (data lake) on AWS"
  value = aws_s3_bucket.datalake.id
}

# S3 bucket (data lake) endpoint
output "s3_bucket_endpoint" {
  description = "S3 bucket (data lake) endpoint."
  value = aws_s3_bucket.datalake.bucket_domain_name
}

# Redshift (data warehouse) admin name
output "redshift_admin_username" {
  description = "Redshift (data warehouse) admin username."
  value = aws_redshift_cluster.default.master_username
}

# Redshift (data warehouse) admin password
output "redshift_admin_password" {
  description = "Redshift (data warehouse) admin password."
  value = aws_redshift_cluster.default.master_password
  sensitive = true
}

# Redshift (data warehouse) database
output "redshift_database" {
  description = "Redshift (data warehouse) database name."
  value = aws_redshift_cluster.default.database_name
}

# Redshift (data warehouse) hostname
output "redshift_hostname" {
  description = "Redshift (data warehouse) hostname."
  value = aws_redshift_cluster.default.endpoint
}

# ARN of IAM role attached to RS cluster
output "redshift_iam_role_arn" {
  description = "ARN of IAM role attached to RS cluster."
  value = aws_iam_role.redshift_role.arn  
}