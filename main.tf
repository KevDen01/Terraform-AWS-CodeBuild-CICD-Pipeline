provider "aws" {
    region = "eu-central-1"
    profile = "KevinKlein"  # In case you have multiple accounts
}

terraform {
  backend "s3" {
    bucket = "kevink-cicd-codebuild-terraform"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws" # Official AWS VPC Module (TF Registry)
  version = "5.16.0"

  name = "KevinK-VPC"
  cidr = "10.0.0.0/16"
  azs             = ["eu-central-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  private_subnet_tags = {   # From the Registry's VPC Module under Inputs
    Name = "kevink-private-subnet"
  }
  public_subnet_tags = {    # From the Registry's VPC Module under Inputs
    Name = "kevink-public-subnet"
  }

  tags = {
    Owner = "KevinK"
  }
}