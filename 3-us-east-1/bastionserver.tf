resource "aws_instance" "back" {
    ami = var.ami
    instance_type = var.instance-type
    key_name = var.key-name
    subnet_id = aws_subnet.pub1.id
    vpc_security_group_ids = [aws_security_group.bastion-host.id ]
    tags = {
      Name= "bastion-server"
    }
}