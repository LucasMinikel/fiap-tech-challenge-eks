module "vpc" {
  source       = "./modules/vpc"
  vpc_name     = local.vpc_name
  azs          = data.aws_availability_zones.available.names
  cluster_name = local.cluster_name
}

module "eks" {
  source          = "./modules/eks"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  cluster_name    = local.cluster_name
}