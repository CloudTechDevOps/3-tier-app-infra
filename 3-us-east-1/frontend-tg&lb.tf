resource "aws_lb_target_group" "front_end" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier ]

}

resource "aws_lb" "front_end" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-frontend-sg.id]
  subnets            = [aws_subnet.pub1.id, aws_subnet.pub2.id]
 
  tags = {
    Name = "ALB-Frontend"
  }
  depends_on = [ aws_lb_target_group.front_end ]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
  depends_on = [ aws_lb_target_group.front_end ]
}


# resource "aws_lb_listener" "front_end2" {
#   load_balancer_arn = aws_lb.front_end.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.front_end.arn
#   }
#   depends_on = [ aws_lb_target_group.front_end ]

# }
