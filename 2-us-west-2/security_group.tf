# Create a sgs

resource "aws_security_group" "bastion-host" {
  name        = "appserver-SG"
  description = "Allow inbound traffic from ALB"
  vpc_id      = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier ]

 ingress {
    description     = "Allow traffic from web layer"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-host-server-sg"
  }
  
}

#  alb-frontend-sg

resource "aws_security_group" "alb-frontend-sg" {
  name        = "alb-frontend-sg"
  description = "Allow inbound traffic from ALB"
  vpc_id      = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier ]

 ingress {
    description     = "http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "https"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-frontend-sg"
  }
  
}


#  alb-backend-sg

resource "aws_security_group" "alb-backend-sg" {
  name        = "alb-backend-sg"
  description = "Allow inbound traffic ALB"
  vpc_id      = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier ]

 ingress {
    description     = "http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "https"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-backend-sg"
  }

}

# frontend server sg
resource "aws_security_group" "frontend-server-sg" {
  name        = "frontend-server-sg"
  description = "Allow inbound traffic "
  vpc_id      = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier,aws_security_group.alb-frontend-sg ]

 ingress {
    description     = "http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "ssh"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frontend-server-sg"
  }

}


#  backend-server-sg

resource "aws_security_group" "backend-server-sg" {
  name        = "backend-server-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier,aws_security_group.alb-backend-sg ]

 ingress {
    description     = "http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "ssh"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend-server-sg"
  }
}


# database security group
resource "aws_security_group" "book-rds-sg" {
  name        = "book-rds-sg"
  description = "Allow inbound "
  vpc_id      = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier ]

 ingress {
    description     = "mysql/aroura"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
 }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "book-rds-sg"
  }

}