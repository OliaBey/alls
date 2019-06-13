provider "aws" {
  access_key = "${var.access_key_var}"
  secret_key = "${var.secret_key_var}"
  region = "${var.region_var}"
}

module "aws_endpoint" {
  source = "../modules/aws_endpoint"
  env_name = "${var.env_name}"
  notebook_name = "${var.notebook_name}"
  region = "${var.region_var}"
  zone = "${var.zone_var}"
  product = "${var.product_name}"
  vpc = "${var.vpc_id}"
  cidr_range = "${var.cidr_range}"
  traefik_cidr = "${var.traefik_cidr}"
  ami_ubuntu = "${var.ami_ubuntu}"
  ami_redhat = "${var.ami_redhat}"
}