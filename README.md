# Acklen Avenue Challenge

The objective for this challente is to deploy this project in NodeJs to a cloud provider.

## Requisites
```requisites
Terraform v 0.12.28
Ansible v 2.9.6
AWS CLI v 2.0.37
AWS Credentials
Python
```

## Deployment Folder

```folders
getKey.py
getEndpoint.py
infra/
    main.tf
    variables.tf
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
app/
    app.yml
    vars.yml
    terraform-inventory

```

## Installation

```bash
# Clone repo
# Configure AWS CLI with your credentials
aws configure
# Go to deployment folder
cd deployment
# Prepare configuration
terraform init infra
# Validate the configuration before apply it
terraform validate infra
# Apply and accept to perform the actions in AWS
terraform apply infra
#Run the following script to extract the private RSA key from terraform.tfstate to use in the next step
python getKey.py infra/terraform.tfstate
#Run the Ansible playbook to prepare the environment and deploy the application
TF_STATE=infra ansible-playbook --inventory-file=app/terraform-inventory --extra-vars "@app/vars.yml" app/app.yml --private-key key_rsa
#Run the following script to extract the endpoint to the application deployed
python getEndpoint.py infra/terraform.tfstate

```
