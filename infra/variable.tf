# Provider
variable "aws_region" {}
variable "aws_profile" {
  description = "AWS credentials profile"
}

# VPC
variable "vpc_cidr" {  }

# Subnets
variable "redshift_subnet_cidr_first" {  }
variable "redshift_subnet_cidr_second" {  }


# Redshift (data warehouse) Cluster
variable "rs_cluster_identifier" {  }
variable "rs_database_name" {  }
variable "rs_master_username" {  }
variable "rs_master_pass" {  }
variable "rs_nodetype" {  }
variable "rs_cluster_type" {  }

# Compute 
variable "availability_zones" {
  description = "List of availability zones"
  default     = ["us-west-1a", "us-west-1c"]
}
