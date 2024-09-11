module "vpc" {
  source = "./modules/vpc"
  project_name = local.project_name
  env = local.env
  region = local.region
  zone1 = local.zone1
  zone2 = local.zone2
}
