provider "aws" {
  region = "us-west-2"
}

module "network" {
  source = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
}

module "compute" {
  source = "./modules/compute"
  ami_id = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id = module.network.subnet_id
}

