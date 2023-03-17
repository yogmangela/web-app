locals {
  hello_world_ec2_docker_demo_name = "web-app-hello-world-${formatdate("YYYY-MM-DD", timestamp())}"
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "hello_world_ec2_docker_demo" {
  ami           = var.ami_id
  instance_type = var.instance_type
  ## - This would need to be randomized
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = ["sg-0f254a344987457e9", ]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_docker_demo_profile.name
  root_block_device {
    volume_size = 20
  }

  user_data                   = file("${path.module}/${var.user_data_file}")
  user_data_replace_on_change = true

  tags = {
    Name           = local.hello_world_ec2_docker_demo_name
    Environment    = var.environment
    Project        = var.project
    App            = var.app
    Provisioned_by = "terraform"
  }
}

## IAM role/policy definition for EC2 Docker demo instance
resource "aws_iam_role" "ec2_docker_demo_iam_role" {
  name = "hello_world_ec2_docker_image_demo_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_docker_demo_profile" {
  name = "hello_world_ec2_docker_image_demo_profile"
  role = aws_iam_role.ec2_docker_demo_iam_role.name
}

resource "aws_iam_role_policy_attachment" "ssmmanagedinstancecore-attach" {
  role       = aws_iam_role.ec2_docker_demo_iam_role.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_role_policy" "ec2_docker_demo_iam_role_policy" {
  name = "AllowECRPullPolicy"
  role = aws_iam_role.ec2_docker_demo_iam_role.id

  ## TODO: comments

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
        ]
        Effect = "Allow"
        ## TODO: Restrict resource definition
        Resource = "*"
      },
      {
        Action = [
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart"
        ]
        Effect = "Allow"
        ## TODO: Restrict resource definition
        Resource = "*"
      },
    ]
  })
}
