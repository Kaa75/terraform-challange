# ─── Application Load Balancer ───
resource "aws_lb" "web" {
name = "Lab-ALB"
internal = false
load_balancer_type = "application"
security_groups = [aws_security_group.alb.id]
subnets = [aws_subnet.public_1.id, aws_subnet.public_2.id]
tags = { Name = "Lab-ALB" }
}
# ─── Target Group ───
resource "aws_lb_target_group" "web" {
name = "Lab-TG"
port = 80
protocol = "HTTP"
vpc_id = aws_vpc.main.id
health_check {
path = "/"
protocol = "HTTP"
healthy_threshold = 2
unhealthy_threshold = 2
timeout = 5
interval = 10
}
tags = { Name = "Lab-TG" }
}
# ─── Register the web server with the target group ───
resource "aws_lb_target_group_attachment" "web" {
target_group_arn = aws_lb_target_group.web.arn
target_id = aws_instance.web.id
port = 80
}
# ─── Listener ───
resource "aws_lb_listener" "web" {
load_balancer_arn = aws_lb.web.arn
port = 80 
protocol = "HTTP"                                                             
default_action {
type = "forward"
target_group_arn = aws_lb_target_group.web.arn
}
}