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
	oc new-project aws-load-balancer-operator

secret-openshift:
	kube/create-secret.sh

operator-openshift:
	oc apply -f kube/operator.yaml

controller-openshift:
	oc apply -f kube/controller.yaml

routers-openshift:
	oc apply -f kube/routers.yaml	

demo-openshift:
	oc apply -f kube/demo.yaml	
