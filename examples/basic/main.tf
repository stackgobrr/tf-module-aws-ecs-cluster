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

# Basic ECS Cluster configuration
module "ecs_cluster" {
  source = "../.."

  project_name = "myapp"
  environment  = "dev"

  log_retention_days = 7

  tags = {
    Project     = "myapp"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

# Outputs
output "cluster_id" {
  description = "ECS Cluster ID"
  value       = module.ecs_cluster.cluster_id
}

output "cluster_name" {
  description = "ECS Cluster Name"
  value       = module.ecs_cluster.cluster_name
}

output "cluster_arn" {
  description = "ECS Cluster ARN"
  value       = module.ecs_cluster.cluster_arn
}

output "log_group_name" {
  description = "CloudWatch Log Group Name"
  value       = module.ecs_cluster.log_group_name
}
