module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  public_route_table_id = module.vpc.public_route_table_id
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}
