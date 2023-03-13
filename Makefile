#
# infra
# 
init-infra:
	cd terraform && terraform init

plan-infra:
	cd terraform && terraform plan -var-file main.tfvars -out main.plan

apply-infra:
	cd terraform && terraform apply -auto-approve main.plan

#
# openshift
#
namespace-openshift:
	oc new-project 3scale-demo

secret-openshift:
	openshift/create-secret.sh

operator-openshift:
	oc apply -f openshift/operator.yaml

controller-openshift:
	oc apply -f openshift/controller.yaml

