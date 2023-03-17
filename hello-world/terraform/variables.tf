variable "region" {
  default = "eu-west-2"
}

variable "ecr_repository_name" {
  type        = string
  description = "Name of the ECR repository"
  default     = "web-app-dev"
}
