# ========= #
# Data Lake #
# ========= #

# S3 Bucket w/ public-read
resource "aws_s3_bucket" "dl" {
  bucket_prefix = "${var.dl_prefix}-"

  tags = {
    Name        = var.dl_prefix
    Environment = var.app_environment
  }
}

resource "aws_s3_bucket_ownership_controls" "dl" {
  bucket = aws_s3_bucket.dl.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "dl" {
  bucket = aws_s3_bucket.dl.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "dl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.dl,
    aws_s3_bucket_public_access_block.dl,
  ]

  bucket = aws_s3_bucket.dl.id
  acl    = "public-read"
}

# ============== #
# Data Warehouse #
# ============== #

# Redshift
resource "aws_redshift_cluster" "dw" {
  cluster_identifier  = "${var.dw_prefix}-cluster"
  database_name       = var.dw_name
  master_username     = var.dw_admin_username
  node_type           = var.dw_node_type
  cluster_type        = var.dw_cluster_type
  cluster_subnet_group_name = ""
}
