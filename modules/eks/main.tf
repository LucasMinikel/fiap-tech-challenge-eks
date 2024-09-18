module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_type = "t3.medium"
    }
  }

  tags = {
    "Name" = var.cluster_name
  }
}
