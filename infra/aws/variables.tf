# AWS Credentials
variable "AWS_ACCESS_KEY_ID" {
  type      = string
  sensitive = true
  default   = "AWS_ACCESS_KEY_ID"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type      = string
  sensitive = true
  default   = "AWS_SECRET_ACCESS_KEY"
}

variable "app_count" {
  type    = number
  default = 1
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-west-1"
}

variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 30
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "mage-elt"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
  default     = "dev"
}


# ================= #
# Storage Variables #
# ================= #

# RDS Instance: PostgreSQL
variable "DATABASE_CONNECTION_URL" {
  type    = string
  default = ""
}

variable "database_name" {
  type        = string
  description = "The name of the Postgres database."
  default     = "mage"
}

variable "database_user" {
  type        = string
  description = "The username of the Postgres database."
  default     = "dbuser"
}

variable "database_password" {
  type        = string
  description = "The password of the Postgres database."
  sensitive   = true
}

variable "database_port" {
  type        = number
  description = "The port number of the Postgres database."
  default     = 5432
}

# Data Lake: S3 Bucket
variable "dl_prefix" {
  type = string
  description = "The prefix of the S3 bucket."
  default = "nyc-tlc-"
}

# Redshift Cluster
variable "dw_prefix" {
  type        = string
  description = "The prefix of the Redshift cluster."
  default     = "nyc-tlc"
}

variable "dw_name" {
  type        = string
  description = "The prefix of the Redshift cluster."
  default     = "nyc-tlc"
}

variable "dw_admin_username" {
  type        = string
  description = "The prefix of the Redshift cluster."
  default     = "dwusername"
}

variable "dw_master_password" {
  type        = string
  description = "The prefix of the Redshift cluster."
  sensitive   = true
}

variable "dw_node_type" {
  type        = string
  description = "The prefix of the Redshift cluster."
  default     = "dc2.large"
}

variable "dw_cluster_type" {
  type        = string
  description = "The prefix of the Redshift cluster."
  default     = "single-node"
}

# ================= # 
# Compute Variables #
# ================= #

variable "docker_image" {
  description = "Docker image url used in ECS task."
  default     = "mageai/mageai:latest"
}

variable "ecs_task_cpu" {
  description = "ECS task cpu"
  default     = 512
}

variable "ecs_task_memory" {
  description = "ECS task memory"
  default     = 1024
}

# ================= #
# Network Variables #
# ================= #

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.32.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
  default     = ["10.32.100.0/24", "10.32.101.0/24"]
}

variable "private_subnets" {
  description = "List of private subnets"
  default     = ["10.32.0.0/24", "10.32.1.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  default     = ["us-west-1a", "us-west-1c"]
}
