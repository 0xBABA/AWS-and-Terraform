##################################################################################
# LOAD BALANCERS
##################################################################################

## create a target group for the ALB
resource "aws_lb_target_group" "hw3_web_alb_tg" {
  name     = format("%s-web-alb-tg", var.global_name_prefix)
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.get_vpc_info.id

  health_check {
    enabled = true
    path    = "/"
  }

  tags = {
    Name = format("%s-web-alb-tg", var.global_name_prefix)
  }
}

## attaching instances to the target group
resource "aws_lb_target_group_attachment" "hw3_web_alb_tg_a" {
  count            = 2
  target_group_arn = aws_lb_target_group.hw3_web_alb_tg.arn
  target_id        = module.web-instance.*.instance_ids
  port             = 80
  depends_on = [
    module.web-instance
  ]
}

## create a listener for the alb
resource "aws_lb_listener" "hw3_alb_listener" {
  load_balancer_arn = aws_lb.hw3_web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hw3_web_alb_tg.arn
  }

  tags = {
    Name = format("%s-web_alb_listener", var.global_name_prefix)
  }
}

## create the ALB
resource "aws_lb" "hw3_web_alb" {
  name               = format("%s-web-alb", var.global_name_prefix)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.web-instance.instance_security_group.*.id]
  subnets            = [data.aws_subnet.get_subnet_info_0.id, data.aws_subnet.get_subnet_info_1.id]

  tags = {
    Name = format("%s-web_alb", var.global_name_prefix)
  }
}

output "hw3_alb_public_dns" {
  value = ["${aws_lb.hw3_web_alb.dns_name}"]
}
