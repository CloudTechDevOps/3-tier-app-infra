resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  identifier = "book-rds"
  db_subnet_group_name   = aws_db_subnet_group.sub-grp.id
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = "db.t3.micro"
  multi_az               = true
  db_name                = "mydb"
  username               = var.rds-username
  password               = var.rds-password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.book-rds-sg.id]
  depends_on = [ aws_db_subnet_group.sub-grp ]
  publicly_accessible = false
  backup_retention_period = 7

  
  tags = {
    DB_identifier = "book-rds"
  }
}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "main"
  subnet_ids = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
  depends_on = [ aws_subnet.prvt7,aws_subnet.prvt8 ]

  tags = {
    Name = "My DB subnet group"
  }
}