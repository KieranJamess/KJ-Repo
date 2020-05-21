# VPC resources
#
resource "aws_vpc" "default" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.default.id
}

resource "aws_route" "private" {
  count = length(var.private_subnet_cidr_blocks)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default[count.index].id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.default.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "var.availability_zones[count.index]-aws_vpc.default.id"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.default.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = flatten([
    aws_route_table.public.id,
    aws_route_table.private.*.id
  ])
}


# NAT resources

resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr_blocks)

  vpc = true
}

resource "aws_nat_gateway" "default" {
  depends_on = [aws_internet_gateway.default]

  count = length(var.public_subnet_cidr_blocks)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
}

# AWS Security group

resource "aws_security_group" "terraform" {
  name   = "terraform"
  vpc_id = aws_vpc.default.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

# AWS Launch Config

resource "aws_launch_configuration" "terraform" {
  image_id        = var.ami
  instance_type   = var.instance_type
  key_name        = "terraform"
  security_groups = ["${aws_security_group.terraform.id}"]

  user_data = <<-EOF
                 #!/bin/bash
                 yum -y install httpd
                 echo 'Website 01!' > /var/www/html/index.html
                 systemctl restart httpd
                 systemctl enable  httpd
                 firewall-cmd --permanent --add-port=80/tcp
                 firewall-cmd --reload
                EOF
  lifecycle {
    create_before_destroy = true
  }

}

# AWS ASG

resource "aws_autoscaling_group" "terraform-ASG-public" {

  launch_configuration = aws_launch_configuration.terraform.id
  vpc_zone_identifier  = ["${aws_subnet.public[0].id}", "${aws_subnet.public[1].id}", "${aws_subnet.public[2].id}"]

  load_balancers    = ["${aws_elb.terraform-elb-public.name}"]
  health_check_type = "ELB"

  max_size = 10
  min_size = 6
}

# AWS ELB

resource "aws_elb" "terraform-elb-public" {

  name            = "terraform-elb-public"
  subnets         = ["${aws_subnet.public[0].id}", "${aws_subnet.public[1].id}", "${aws_subnet.public[2].id}"]
  security_groups = ["${aws_security_group.terraform.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 30
    target              = "HTTP:80/"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

# Bastion resources
#
#resource "aws_security_group" "bastion" {
#  vpc_id = aws_vpc.default.id
#}
#
#resource "aws_network_interface_sg_attachment" "bastion" {
#  security_group_id    = aws_security_group.bastion.id
#  network_interface_id = aws_instance.bastion.primary_network_interface_id
#}
#
#resource "aws_instance" "bastion" {
#  ami                         = var.bastion_ami
#  availability_zone           = var.availability_zones[0]
#  ebs_optimized               = var.bastion_ebs_optimized
#  instance_type               = var.bastion_instance_type
#  key_name                    = var.key_name
#  monitoring                  = true
#  subnet_id                   = aws_subnet.public[0].id
#  associate_public_ip_address = true
#}
