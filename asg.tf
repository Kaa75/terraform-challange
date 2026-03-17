# ─── Launch Template ───
resource "aws_launch_template" "web" {
name_prefix = "Lab-LT-"
image_id = data.aws_ami.amazon_linux.id
instance_type = "t3.micro"
key_name = var.key_name
vpc_security_group_ids = [aws_security_group.web.id]
user_data = base64encode(file("userdata/web.sh"))
tag_specifications {
resource_type = "instance"
tags = { Name = "ASG-Web-Server" }
}
}
# ─── Auto Scaling Group ───
resource "aws_autoscaling_group" "web" {
name = "Lab-ASG"
desired_capacity = 2
min_size = 1
max_size = 4
vpc_zone_identifier = [aws_subnet.public_1.id, aws_subnet.public_2.id]
target_group_arns = [aws_lb_target_group.web.arn]
launch_template {
id = aws_launch_template.web.id
version = "$Latest"                                                        
}
health_check_type = "ELB"
health_check_grace_period = 120
tag {
key = "Name"
value = "ASG-Web-Server"
propagate_at_launch = true
}
}
# ─── Scaling Policy (scale up when CPU > 70%) ───
resource "aws_autoscaling_policy" "scale_up" {
name = "Lab-Scale-Up"
autoscaling_group_name = aws_autoscaling_group.web.name
policy_type = "TargetTrackingScaling"
target_tracking_configuration {
predefined_metric_specification {
predefined_metric_type = "ASGAverageCPUUtilization"
}
target_value = 70.0
}
}