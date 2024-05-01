

# Create a VPC for Redshift Cluster
resource "aws_vpc" "redshift_vpc" {

  cidr_block = "${var.vpc_cidr}"

  instance_tenancy = "default"
  
  tags = {
  
    Name = "redshift-vpc"
  
  }

}


# Internet Gateway (for VPC)
resource "aws_internet_gateway" "redshift_vpc_gw" {
  
  vpc_id = "${aws_vpc.redshift_vpc.id}"
  
  depends_on = [ aws_vpc.redshift_vpc ]

}


# Default Security Group for VPC
resource "aws_default_security_group" "redshift_security_group" {

    vpc_id     = "${aws_vpc.redshift_vpc.id}"

    ingress {
        from_port   = 5439
        to_port     = 5439
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "redshift-sg"
    }

    depends_on = [ aws_vpc.redshift_vpc ]

}


# Subnets
resource "aws_subnet" "redshift_subnet_1" {
  
  vpc_id = "${aws_vpc.redshift_vpc.id}"
  
  cidr_block = "${var.redshift_subnet_cidr_first}"

  availability_zone = "us-west-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "redshift-subnet-1"
  }

  depends_on = [ aws_vpc.redshift_vpc ]

}
resource "aws_subnet" "redshift_subnet_2" {
  
  vpc_id     = "${aws_vpc.redshift_vpc.id}"

  cidr_block        = "${var.redshift_subnet_cidr_second}"

  availability_zone = "us-west-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "redshift-subnet-2"
  }

  depends_on = [ aws_vpc.redshift_vpc ]
}


# Redshift Subnet Group
resource "aws_redshift_subnet_group" "redshift_subnet_group" {

  name       = "redshift-subnet-group"

  subnet_ids = [
    "${aws_subnet.redshift_subnet_1.id}",
    "${aws_subnet.redshift_subnet_2.id}"
  ]
  
  tags = {
    environment = "dev"
    Name = "redshift-subnet-group"
  }
}


# IAM Role Policy
resource "aws_iam_role_policy" "s3_full_access_policy" {

  name = "redshift_s3_policy"

  role = "${aws_iam_role.redshift_role.id}"

  policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
    }
    EOF
}

# IAM Role
resource "aws_iam_role" "redshift_role" {
  
  name = "redshift_role"

  tags = {
    tag-key = "redshift-role"
  }
  
  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "redshift.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
    ]
    }
    EOF
}


# Data Warehouse: Redshift Cluster
resource "aws_redshift_cluster" "default" {

  cluster_identifier = "${var.rs_cluster_identifier}"

  database_name      = "${var.rs_database_name}"

  master_username    = "${var.rs_master_username}"

  master_password    = "${var.rs_master_pass}"

  node_type          = "${var.rs_nodetype}"

  cluster_type       = "${var.rs_cluster_type}"

  cluster_subnet_group_name = "${aws_redshift_subnet_group.redshift_subnet_group.id}"

  skip_final_snapshot = true

  iam_roles = ["${aws_iam_role.redshift_role.arn}"]
  
  depends_on = [
    aws_vpc.redshift_vpc,
    aws_default_security_group.redshift_security_group,
    aws_redshift_subnet_group.redshift_subnet_group,
    aws_iam_role.redshift_role
  ]
}

# Data Lake: S3 Bucket
resource "aws_s3_bucket" "datalake" {
  bucket_prefix = "nyc-tlc-"
  force_destroy = true
}

# S3 Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "datalake" {
  bucket = aws_s3_bucket.datalake.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# S3 Bucket Access Block
resource "aws_s3_bucket_public_access_block" "datalake" {
  bucket = aws_s3_bucket.datalake.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 Bucket ACL (Public Read)
resource "aws_s3_bucket_acl" "datalake" {
  depends_on = [
    aws_s3_bucket_ownership_controls.datalake,
    aws_s3_bucket_public_access_block.datalake,
  ]

  bucket = aws_s3_bucket.datalake.id
  acl    = "public-read"
}
