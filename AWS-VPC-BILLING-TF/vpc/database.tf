resource "aws_rds_cluster_instance" "cluster_instances" {
  count               = 3
  identifier          = "aurora-cluster-${count.index}"
  cluster_identifier  = aws_rds_cluster.aurora-cluster.id
  instance_class      = "db.r4.large"
  publicly_accessible = true
}

resource "aws_rds_cluster" "aurora-cluster" {
  cluster_identifier   = "aurora-cluster"
  database_name        = "mydb"
  apply_immediately    = true
  db_subnet_group_name = aws_db_subnet_group.db-private.id
  master_username      = "foo"
  master_password      = "barbut8chars"
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "db-private" {
  name       = "db-private"
  subnet_ids = ["${aws_subnet.private[0].id}", "${aws_subnet.private[1].id}", "${aws_subnet.private[2].id}"]
}
