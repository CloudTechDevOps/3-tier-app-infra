


resource "aws_instance" "back" {
    ami = var.ami
    instance_type = var.instance-type
    key_name = var.key-name
    # subnet_id = aws_subnet.pub2.id
    # vpc_security_group_ids = [aws_security_group.backend-server-sg.id ]
    user_data = templatefile("./backend.sh", {})
    tags = {
      Name= "backend-server"
    }
}