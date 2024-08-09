resource "aws_lb_target_group" "back_end" {
  name     = "backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier.id
  depends_on = [ aws_vpc.three-tier ]

}

resource "aws_lb" "back_end" {
  name               = "backend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-backend-sg.id]
  subnets            = [aws_subnet.pub1.id, aws_subnet.pub2.id]
  depends_on = [ aws_lb_target_group.back_end ]
  tags = {
    Name = "ALB-backend"
  }
}

resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.back_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_end.arn
  }
  depends_on = [ aws_lb_target_group.back_end ]
}


# resource "aws_lb_listener" "back_end2" {
#   load_balancer_arn = aws_lb.back_end.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.back_end.arn
#   }
#   depends_on = [ aws_lb_target_group.back_end ]
  
# }
