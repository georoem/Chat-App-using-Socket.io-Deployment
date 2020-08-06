# The cloud provider is AWS
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# Module to generate the RSA Key to connect the instances
module "key" {
  source    = "./modules/key"
  key_name  = var.key_name
}

# Module to build the networking like VPC, Subnets, Internet Gateway, Routes, etc
module "net" {
  source             = "./modules/net"
  availability_zones = var.availability_zones
  project            = var.project
  environment        = var.environment
}

# Module to build the security groups
module "sg" {
  source      = "./modules/sg"
  vpc_id      = module.net.vpc_id
  subnet_ids  = module.net.subnet_ids
  project     = var.project
  environment = var.environment
}

# Module to build the instances
module "ec2" {
  source        = "./modules/ec2"
  subnet_ids    = module.net.subnet_ids
  sg_ids        = [module.sg.sg_ssh_id, module.sg.sg_internet_id]
  key_pair_name = var.key_name
  project       = var.project
  environment   = var.environment
}

# Module to build the Load Balancer
module "elb" {
  source             = "./modules/elb"
  instance_ids       = module.ec2.instance_ids
  availability_zones = var.availability_zones
  subnet_ids         = module.net.subnet_ids
  project            = var.project
  environment        = var.environment
  sg_ids             = [module.sg.sg_internet_id]
}