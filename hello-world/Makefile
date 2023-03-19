MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.DEFAULT_GOAL := help
.ONESHELL:

AWS_DEFAULT_REGION ?= eu-west-2
# ECR_REPOSITORY ?= "web-app-dev"
DOCKER_REPOSITORY ?= "web-app"
# ECR_REGISTRY ?= "{Add-your-AWS-acc-id}.dkr.ecr.eu-west-2.amazonaws.com"
DOCKER_REGISTRY ?= "yogmicroservices"
DOCKER_HOST=$(HOST)
IMAGE_TAG ?= 0.0.0
PROJECT_NAME := "web-app-prj"
IMAGE_NAME ?= "birthday"

.PHONY: help
help:    ## Show this help - team1 app
	@grep '.*:.*##' Makefile | grep -v grep  | sort | sed 's/:.* ##/:/g' | column -t -s:

# Provision AWS ECR repositiry
.PHONY: fmt
fmt:    ## Format terraform to canonical format and style - team1 app
	@echo "Terraform format - AWS ECR"
	cd ./terraform/
	terraform fmt

.PHONY: init
init:    ## Initialize working directory - team1 app
	@echo "Terraform Init - AWS ECR"
	cd ./terraform/ && \
	terraform init

.PHONY: validate
validate:    ## Validate TF config files - team1 app
	@echo "Terraform Validate - AWS ECR"
	cd ./terraform/ && \
	terraform validate

# .PHONY: plan
# plan:     ## Generate terraform execution plan - team1 app
# 	@echo "Terraform Plan - AWS ECR"
# 	cd ./terraform/ && \
# 	terraform plan

# .PHONY: apply
# apply:    ## Execute actions proposed in Terraform plan - team1 app
# 	@echo "Terraform Apply - AWS ECR"
# 	cd ./terraform/ && \
# 	terraform apply -auto-approve

# # NOTE: run locally only
# .PHONY: destroy
# destroy:    ## Destroy terraform resources created by previous "terraform apply"
# 	@echo "Terraform Destroy - AWS ECR"
# 	cd ./terraform/ && \
# 	terraform destroy

# Docker build scan push to ECR
# ========================================================================

.PHONY: lint
lint:   ## Dockerfile lint
	@echo "--------------------------------"
	@echo "Dockerfile lint..."
	@echo "--------------------------------"
	docker run --rm -i hadolint/hadolint < ./src/Dockerfile


# run locally only
.PHONY: login-docker
login-docker:   ## Log in to AWS ECR to push image locally only
	@echo "------------------------------------------------------------------"
	@echo "Logging in to AWS ECR registry..."
	@echo "------------------------------------------------------------------"
	docker login 

.PHONY: build
build:   ## Build the container image locally
	@echo "-------------------------------------------"
	@echo "Building and tagging container image..."
	@echo "-------------------------------------------"
	docker build --platform=linux/amd64 -t ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG} ./src/

.PHONY: image-scan
image-scan:      ## Run Trivy vulnerability scanner
	@echo "-----------------------------------------"
	@echo "Running trivy vulnerability scanner..."
	@echo "-----------------------------------------"
	docker run --platform=linux/amd64 --rm \
	    -v /var/run/docker.sock:/var/run/docker.sock \
		-e DOCKER_REGISTRY=$(DOCKER_REGISTRY) \
		-e DOCKER_REPOSITORY=${DOCKER_REPOSITORY} \
		-e IMAGE_TAG=${IMAGE_TAG} \
		-e PROJECT_NAME=${PROJECT_NAME} \
		-e IMAGE_NAME=${IMAGE_NAME} \
		public.ecr.aws/aquasecurity/trivy:canary image ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG} -s "HIGH,CRITICAL" --timeout 30m

# # run locally only  AWS
# .PHONY: login-ecr AWS
# login-ecr:   ## Log in to AWS ECR to push image locally only
# 	@echo "------------------------------------"
# 	@echo "Logging in to AWS ECR registry..."
# 	@echo "------------------------------------"
# 	aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | \
# 	docker login --username ${DOCKER_USERNAME} --password-stdin ${ECR_REGISTRY}

# .PHONY: build
# build:   ## Build and Tag the container image AWS
# 	@echo "-------------------------------------------"
# 	@echo "Building and tagging container image..."
# 	@echo "-------------------------------------------"
# 	docker build --platform=linux/amd64 -t ${ECR_REGISTRY}/${ECR_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG} ./src/

# .PHONY: image-scan AWS
# image-scan:      ## Run Trivy vulnerability scanner
# 	@echo "-----------------------------------------"
# 	@echo "Running trivy vulnerability scanner..."
# 	@echo "-----------------------------------------"
# 	docker run --platform=linux/amd64 --rm \
# 	    -v /var/run/docker.sock:/var/run/docker.sock \
# 		-e ECR_REGISTRY=${ECR_REGISTRY} \
# 		-e ECR_REPOSITORY=${ECR_REPOSITORY} \
# 		-e IMAGE_TAG=${IMAGE_TAG} \
# 		-e PROJECT_NAME=${PROJECT_NAME} \
# 		-e IMAGE_NAME=${IMAGE_NAME} \
# 		public.ecr.aws/aquasecurity/trivy:canary image ${ECR_REGISTRY}/${ECR_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG} -s "HIGH,CRITICAL"

# .PHONY: push
# push:    ## Push image to AWS ECR AWS
# 	@echo "----------------------------------------"
# 	@echo "Pushing image to AWS ECR registry..."
# 	@echo "----------------------------------------"
# 	docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG}

.PHONY: push
push:    ## Push image to AWS ECR AWS
	@echo "----------------------------------------"
	@echo "Pushing image to AWS ECR registry..."
	@echo "----------------------------------------"
	docker push ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG}

# # NOTE: run locally only AWS
# .PHONY: cleanup
# cleanup:   ## Clean up after push
# 	docker rmi ${ECR_REGISTRY}/${ECR_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG}	
# 	docker image prune $(shell docker ps -a -q)

# NOTE: run local only
.PHONY: cleanup
cleanup:   ## Clean up after push
	docker rmi ${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}:${PROJECT_NAME}-${IMAGE_NAME}-${IMAGE_TAG}	
	docker image prune $(shell docker ps -a -q)