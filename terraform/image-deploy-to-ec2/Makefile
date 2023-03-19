MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.DEFAULT_GOAL := help
.ONESHELL:

.PHONY: help
help:    ## Show this help
	@grep '.*:.*##' Makefile | grep -v grep  | sort | sed 's/:.* ##/:/g' | column -t -s:

.PHONY: fmt
fmt:    ## Format terraform to canonical format and style
	@echo "Terraform format"
	terraform fmt

.PHONY: init
init:    ## Initialize working directory
	@echo "Terraform Init"
	terraform init

.PHONY: validate
validate:    ## Validate TF config files
	@echo "Terraform Validate"
	terraform validate

# .PHONY: plan
# plan:     ## Generate terraform execution plan
# 	@echo "Terraform Plan"
# 	terraform plan

# .PHONY: apply
# apply:    ## Execute actions proposed in Terraform plan
# 	@echo "Terraform Apply"
# 	terraform apply -auto-approve

# # NOTE: run locally only
# .PHONY: destroy
# destroy:    ## Destroy terraform resources created by previous "terraform apply"
# 	@echo "Terraform Destroy"
# 	terraform destroy
