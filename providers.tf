terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.3.0"


  #backend "s3" {
  #   bucket  = "challenge-states"
  #   key     = "state/terraform.tfstate" #CAMBIAR EL NOMBRE PARA LA KEY/FOLDER
  #   region  = "us-east-1"
  #   profile = "personal"
  #}
}

provider "aws" {
  region = "us-east-1"
  profile = "personal"
}
