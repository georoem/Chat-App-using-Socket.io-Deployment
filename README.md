# Acklen Avenue Challenge

The objective for this challente is to deploy the project [Chat-App-using-Socket.io](https://github.com/abkunal/Chat-App-using-Socket.io) in NodeJs to a cloud provider.

## Requisites
  * Linux OS
  * [Terraform v 0.12.28](https://learn.hashicorp.com/tutorials/terraform/install-cli)
  * [Ansible v 2.9.6](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
  * [AWS CLI v 2.0.37](https://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-chap-install.html)
  * [AWS Credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)
  * [Python](https://www.python.org/downloads/)

## Deployment Contents

```folders
getKey.py           <- Script to extract rsa key from terraform.tfstate
getEndpoint.py      <- Script to extract endpoint to app from terraform.tfstate
infra/              <- Terraform files
    main.tf
    vars.tf
    modules/
        ec2/
            ec2.tf
            vars.tf
        net/
            net.tf
            vars.tf
        elb/
            elb.tf
            vars.tf
        sg/
            sg.tf
            vars.tf
        key/
            key.tf
            vars.tf
app/                <- Ansible files
    app.yml
    vars.yml
    terraform-inventory

```

## Installation

```bash
# Clone repo
git clone https://github.com/georoem/Chat-App-using-Socket.io-Deployment.git  
# Configure AWS CLI with your credentials
aws configure
# Go to project folder
cd Chat-App-using-Socket.io-Deployment
# Prepare configuration
terraform init infra
# Validate the configuration before apply it
terraform validate infra
# Apply and accept to perform the actions in AWS
terraform apply -auto-approve infra 
# Run the following script to extract the private RSA key from terraform.tfstate to use in the next step
python getKey.py terraform.tfstate
# Run the Ansible playbook to prepare the environment and deploy the application and accept the first connection to each instance
TF_STATE=./ ansible-playbook --inventory-file=app/terraform-inventory --extra-vars "@app/vars.yml" app/app.yml --private-key key_rsa
# Run the following script to extract the endpoint to the application deployed
python getEndpoint.py terraform.tfstate
# Go to the endpoint extracted 
```
