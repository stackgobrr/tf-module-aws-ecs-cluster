terraform {
  required_version = ">= 1.14.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

# Complete ECS Cluster configuration with all options
module "ecs_cluster" {
  source = "../.."

  project_name = "h3ow3d"
  environment  = "production"

  # Extended log retention for production
  log_retention_days = 30

  # Comprehensive tagging
  tags = {
    Project     = "h3ow3d"
    Environment = "production"
    ManagedBy   = "terraform"
    CostCenter  = "engineering"
    Compliance  = "required"
    Backup      = "daily"
  }
}

# Outputs
output "cluster_id" {
  description = "ECS Cluster ID for service deployments"
  value       = module.ecs_cluster.cluster_id
}

output "cluster_name" {
  description = "ECS Cluster Name for task definitions"
  value       = module.ecs_cluster.cluster_name
}

output "cluster_arn" {
  description = "ECS Cluster ARN for IAM policies"
  value       = module.ecs_cluster.cluster_arn
}

output "log_group_name" {
  description = "CloudWatch Log Group for container logs"
  value       = module.ecs_cluster.log_group_name
}

# Example: How to reference this module in your deployment
# 
# In your h3ow3d-deployment repository main.tf:
#
# module "ecs_cluster" {
#   source = "git::https://github.com/h3ow3d/h3ow3d-infra-ecs-cluster.git?ref=v1.0.0"
#
#   project_name       = var.project_name
#   environment        = var.environment
#   log_retention_days = 30
#   tags               = local.common_tags
# }
