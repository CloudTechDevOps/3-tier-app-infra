variable "ami" {
    description = "ami"
    type = string
    default = "ami-04b70fa74e45c3917"
  
}
variable "instance-type" {
    description = "instance-type"
    type = string
    default = "t2.micro"
  
}
variable "key-name" {
    description = "keyname"
    type = string
    default = "aws_key"
  
}