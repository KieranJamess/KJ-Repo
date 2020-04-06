## Overview

This creates a VPC in the defined region, that contains 3 AZ's. Each AZ has a public and private subnet. It also creates the private subnets as a database subnet and create a RDS cluster on the DB subnets split across the 3 AZ's.

## VPC

Creates a VPC in a region, with 3 AZ's. The CIDR block is set to 10.100.X.X. It also creates 6 submets, 3 private and 3 public and each AZ gets a public and private subnet. 

Each AZ gets a subnet in order to the AZ, for example, AZ A gets 10.100.1.X and 10.100.2.X. 

The subets have assigned route tables and depending on private or public subnet, it will go to a IGW and NAT gateway. 

This also creates VPC logs.

## ELB, ASG, Keypair and Launch Config

This creates a launch config that the ASG uses to create EC2 instances. The EC2 instances use the Keypair file for SSH access.

## RDS cluster

The RDS cluster creates 3 RDS instances that is split between the private subnets. This is running the aurora engine.
