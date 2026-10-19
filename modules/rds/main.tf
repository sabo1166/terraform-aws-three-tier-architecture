resource "aws_db_subnet_group" "this" {
  name        = "${var.name}-db-subnets"
  subnet_ids  = var.private_db_subnets
  description = "Private database subnets across two Availability Zones"

  tags = { Name = "${var.name}-db-subnets" }
}

resource "aws_security_group" "this" {
  name        = "${var.name}-rds-sg"
  description = "Allow MySQL only from the app EC2 security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from application instances"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-rds-sg" }
}

resource "aws_db_instance" "this" {
  identifier                 = substr("${var.name}-mysql", 0, 63)
  engine                     = "mysql"
  engine_version             = "8.0"
  instance_class             = var.db_instance_class
  allocated_storage          = 20
  max_allocated_storage      = 50
  storage_type               = "gp3"
  storage_encrypted          = true
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = var.db_password
  port                       = 3306
  db_subnet_group_name       = aws_db_subnet_group.this.name
  vpc_security_group_ids     = [aws_security_group.this.id]
  publicly_accessible        = false
  multi_az                   = false
  backup_retention_period    = 1
  auto_minor_version_upgrade = true
  deletion_protection        = false
  skip_final_snapshot        = true
  apply_immediately          = false

  tags = { Name = "${var.name}-mysql" }
}
