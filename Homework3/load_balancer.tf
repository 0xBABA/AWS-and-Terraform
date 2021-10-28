##################################################################################
# LOAD BALANCERS
##################################################################################

## create a target group for the ALB
resource "aws_lb_target_group" "hw2_alb_tg" {
  name     = "hw2-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.hw2_main_vpc.id

  health_check {
    enabled = true
    path    = "/"
  }

  tags = {
    Name = "hw2_alb_tg"
  }
}

## attaching instances to the target group
resource "aws_lb_target_group_attachment" "hw2_alb_tg_a" {
  count            = 2
  target_group_arn = aws_lb_target_group.hw2_alb_tg.arn
  target_id        = aws_instance.hw2_web_instance.*.id[count.index]
  port             = 80
}

## create a listener for the alb
resource "aws_lb_listener" "hw2_alb_listener" {
  load_balancer_arn = aws_lb.hw2_pub_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hw2_alb_tg.arn
  }

  tags = {
    Name = "hw2_alb_listener"
  }
}

## create the ALB
resource "aws_lb" "hw2_pub_alb" {
  name               = "hw2-pub-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.hw2_nginx_sg.id]
  subnets            = aws_subnet.hw2_pub_sn.*.id

  tags = {
    Name = "hw2-pub-alb"
  }
}

output "hw2_alb_public_dns" {
  value = ["${aws_lb.hw2_pub_alb.dns_name}"]
}
