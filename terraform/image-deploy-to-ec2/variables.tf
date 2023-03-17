variable "project" {
  default = "hello_world"
}

variable "environment" {
  default = "Dev"
}

variable "vpc_id" {
  default = "vpc-02335930770cc2abe"
}

variable "public_subnet_id" {
  default = "subnet-0d8f7ffb28eefb4a2"
}

variable "region" {
  default = "eu-west-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "user_data_file" {
  type        = string
  description = "local path to the user-data to be executed on the EC2 instance"
  default     = "user-data.sh"
}

variable "key_pair_name" {
  type        = string
  description = "SSH key-pair name"
  default     = "web-app-hello-world"
}

variable "ami_id" {
  default = "ami-084e8c05825742534"
}

variable "app" {
  default = "web-app-hello-world"
}