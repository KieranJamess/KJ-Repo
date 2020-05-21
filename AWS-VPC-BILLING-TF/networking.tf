module "aws_vpc" {
  source = "./vpc/"
}

#module "us-east" {
#  source = "./vpc/"
#
#  region = "us-east-1"
#  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
#}
