variable "vpc_name" {
 type    = string
}

variable "cluster_name" {
    type    = string
}

variable "azs" {
  type    = list(string)
}

variable "vpc_cidr" {
  type    = string
  default = "10.123.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.123.3.0/24", "10.123.4.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.123.1.0/24", "10.123.2.0/24"]
}

variable "intra_subnets" {
  type    = list(string)
  default = ["10.123.5.0/24", "10.123.6.0/24"]
}