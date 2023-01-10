init:
	terraform init

plan:
	terraform plan -var-file fixtures.tfvars -out tfplan

apply:
	terraform apply tfplan

destroy:
	terraform destroy -var-file fixtures.tfvars
