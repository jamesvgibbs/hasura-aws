# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# -----------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# -----------------------------------------------------------------------------
# PARAMETERS
# -----------------------------------------------------------------------------

variable "region" {
  description = "Region to deploy"
  default     = "us-east-2" # US East (Ohio)
}

variable "existing_vpc" {
  description = "The existing VPC ID"
  default = "vpc-xxxxxxx"
}

variable "vpc_subnets" {
  description = "List of Subnet IDs"
  default = [
    "subnet-xxxxx",
    "subnet-xxxxx"
  ]
}

variable "domain" {
  description = "Domain name. Service will be deployed using the hasura_subdomain"
  default = "domain.com"
}

variable "hasura_subdomain" {
  description = "The Subdomain for your hasura graphql service."
  default     = "hasura"
}

variable "app_subdomain" {
  description = "The Subdomain for your application that will make CORS requests to the hasura_subdomain"
  default     = "apphasura"
}
variable "hasura_version_tag" {
  description = "The hasura graphql engine version tag"
  default     = "v2.17.1"
}

variable "hasura_admin_secret" {
  description = "The admin secret to secure hasura; for admin access"
  default = "hasura_admin_secret"
  type = string
}

variable "hasura_jwt_secret_key" {
  description = "The secret shared key for JWT verification"
  default = "hasura_jwt_secret_key"
  type = string
}

variable "hasura_jwt_secret_algo" {
  description = "The algorithm for JWT verification (HS256 or RS256)"
  default     = "HS256"
}

variable "hasura_console_enabled" {
  description = "Should the Hasura Console web interface be enabled?"
  default     = "true"
}

variable "rds_username" {
  description = "The username for RDS"
  default = "hasuraapp"
}

variable "rds_password" {
  description = "The password for RDS"
  default = "rds_password"
  type = string
}

variable "rds_db_name" {
  description = "The DB name in the RDS instance"
  default = "hasura01"
}

variable "rds_instance" {
  description = "The size of RDS instance, eg db.t3.micro"
  default = "db.t3.micro"
}

variable "rds_storage_encrypted" {
  description = "Whether the data on the PostgreSQL instance should be encrpyted."
  default     = false
}

variable "az_count" {
  description = "How many AZ's to create in the VPC"
  default     = 2
}

variable "multi_az" {
  description = "Whether to deploy RDS and ECS in multi AZ mode or not"
  default     = false
}

variable "additional_db_security_groups" {
  description = "List of Security Group IDs to have access to the RDS instance"
  default     = [
    "sg-xxxxxx"
  ]
}

variable "ecs_cluster_name" {
  description = "The name to assign to the ECS cluster"
  default     = "hasura-cluster"
}
