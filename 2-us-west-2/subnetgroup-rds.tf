resource "aws_db_subnet_group" "sub-grp" {
  name       = "main"
  subnet_ids = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
  depends_on = [ aws_subnet.prvt7,aws_subnet.prvt8 ]

  tags = {
    Name = "My-DB-subnet-group"
  }
}