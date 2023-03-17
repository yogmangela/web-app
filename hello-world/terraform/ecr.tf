## AWS ECR (private) repository for initial dev hello-world app
resource "aws_ecr_repository" "web_app_dev" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "repository_url" {
  value = aws_ecr_repository.web_app_dev.repository_url
}
