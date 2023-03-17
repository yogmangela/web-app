PROJECT_NAME = "birthday"

.PHONY: help
help:    ## Show this help - team1 app
	@grep '.*:.*##' Makefile | grep -v grep  | sort | sed 's/:.* ##/:/g' | column -t -s:


# Docker compose build
.PHONY: conf
conf:    ## to Parse, resolve and render compose file in canonical format
	@echo "Docker compose build"
	docker compose config


# Docker compose build
.PHONY: build
build:    ## To Create and start containers and To Build or rebuild services web app and db app
	@echo "Docker compose build"
	docker compose -p ${PROJECT_NAME} up --build

# Docker compose down
.PHONY: down
down:    ## to Stop and remove containers, networks  web app and db app
	@echo "Docker compose down"
	docker-compose down


# MAKEFLAGS += --warn-undefined-variables
# SHELL := /bin/bash
# .DEFAULT_GOAL := help
# .ONESHELL:

# AWS_DEFAULT_REGION ?= eu-west-2
# ECR_REPOSITORY ?= "web-app-dev"
# ECR_REGISTRY ?= "{{Your-ECR-REPO}}"
# IMAGE_TAG ?= 0.0.4
# DOCKER_USERNAME := AWS
# PROJECT_NAME := "hello-world-app-prj"
# IMAGE_NAME ?= "happy-birth-day"
