
data "aws_db_subnet_group" "readreplica" {
    provider = aws.secondary
    name = "main"
}
data "aws_security_group" "vsv" {
    provider = aws.secondary
   filter {
    name = "tag:Name"
    values = ["book-rds-sg"] # give your subnet name 
  }
}

resource "aws_db_instance" "replica-postgresql-rds" {
  provider = aws.secondary
  identifier = "book-rds-read-replica"
  instance_class       = "db.t3.micro"
  skip_final_snapshot  = true
  # identifier = "book-read"
  backup_retention_period = var.backupr-retention
  replicate_source_db = aws_db_instance.rds.arn
  db_subnet_group_name   = data.aws_db_subnet_group.readreplica.id
  vpc_security_group_ids = [data.aws_security_group.vsv.id]
  depends_on = [ aws_db_instance.rds ]  
  publicly_accessible = true
}

output "replica-url" {
  value=aws_db_instance.replica-postgresql-rds.endpoint
}