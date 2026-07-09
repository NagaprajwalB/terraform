# main.tf
# Production wires together shared modules rather than
# redefining raw resources — keeps prod consistent with staging/dev.

module "network" {
  source   = "../../modules/network"
  vpc_cidr = var.vpc_cidr
  env      = "prod"
}

module "compute" {
  source        = "../../modules/compute"
  instance_type = var.instance_type
  min_capacity  = var.min_capacity
  max_capacity  = var.max_capacity
  subnet_ids    = module.network.private_subnet_ids
  vpc_id        = module.network.vpc_id
  env           = "prod"
}

module "database" {
  source      = "../../modules/database"
  db_password = var.db_password
  subnet_ids  = module.network.private_subnet_ids
  vpc_id      = module.network.vpc_id
  env         = "prod"
}
