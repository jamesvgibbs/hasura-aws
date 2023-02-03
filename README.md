# Hasura on AWS

Terraform module to deploy [Hasura GraphQL Engine](https://github.com/hasura/graphql-engine) on AWS. This will deploy
across multiple Availability Zones (AZ) with the following components:

- Postgres RDS deployed in multiple AZ
- Hasura GraphQL Engine in [Fargate](https://aws.amazon.com/fargate/) across multiple AZ
- ALB for load balancing between the hasura tasks
- Certificate issued by ACM for securing traffic to ALB
- Logging for RDS, ECS, and ALB into Cloudwatch Logs

## Requirements

- AWS account
  - IAM user
- Terraform v1.2.4

## Usage

Copy and paste into your Terraform configuration, edit the variables, and run `terraform init` then `terraform apply`

```json
 terraform module "hasura" {
  region                          = "YOUR DEPLOYMENT REGION"
  hasura_subdomain                = "HASURA ENDPOINT SUBDOMAIN"
  app_subdomain                   = "YOUR HASURA APP SUBDOMAIN (FOR CORS)"
  hasura_version_tag              = "HASURA VERSION TAG FOR DEPLOYMENT"
  hasura_admin_secret             = "YOUR HASURA ADMIN SECRET"
  hasura_jwt_secret_key           = "YOUR PUBLIC KEY FOR JWT VERIFICATION"
  hasura_console_enabled          = "ENABLE HASURA CONSOLE"
  rds_db_name                     = "YOUR DATABASE NAME"
  rds_instance                    = "YOUR DATABASE INSTANCE SIZE"
  rds_username                    = "YOUR DATABASE USERNAME"
  rds_password                    = "YOUR DATABASE PASSWORD"
  rds_storage_encrypted           = "ENABLE DATABASE ENCRYPTION"
  multi_az                        = "ENABLE MULTIPLE AVAILABILITY ZONES"
  az_count                        = "NUMBER OF AVAILABILITY ZONES"
  additional_db_security_groups   = "ADDITIONAL GROUPS ASSIGNED TO RDS INSTANCE"
  ecs_cluster_name                = "YOUR CLUSTER NAME"
}
```
You will also need to create a `hasura.tfvars` file to house three different valriables. 

```text
hasura_admin_secret = "admin_password"
hasura_jwt_secret_key = "json_secret_key"
rds_password = "somecrypticpassword"
```
You need to search for `domain.com` and switch this for your specific domain. This is assuming you are hosing your DNS on Route53.

### Additional info about variables

- `hasura_version_tag` comes from [here](https://hub.docker.com/r/hasura/graphql-engine/tags?page=1&ordering=last_updated) (e.g. "v.2.8.3")
- `az_count` needs to be at least 2 or higher (due to AWS constraints, an rds instance must have at least one availability zone for failover)
- `hasura_console_enabled` must be a string (i.e. `"true"`) and NOT a boolean (i.e. `true`). Other true/false variables can be booleans
- `rds_db_name` must only contain alphanumeric characters and start with a letter
- `ecs_cluster_name` must only contain alphanumeric characters and start with a letter

## Glossary

If you need to remove Hasura then run the following Terraform `terraform destroy`

## Glossary

- AZ: Availability Zone
- ALB: Application Load Balancer
- ACM: AWS Certificate Manager
- ECS: Elastic Container Service
- RDS: Relational Database Service
