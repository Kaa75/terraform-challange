output "vpc_id" {
description = "ID of the VPC"
value = aws_vpc.main.id
}
output "alb_dns_name" {
description = "DNS name of the Application Load Balancer"
value = aws_lb.web.dns_name
} 
output "bastion_public_ip" {
description = "Public IP of the bastion host"
value = aws_instance.bastion.public_ip
}
output "web_server_public_ip" {
description = "Public IP of the web server"
value = aws_instance.web.public_ip
}
output "db_password_ssm_path" {
description = "SSM path for the database password"
value = aws_ssm_parameter.db_password.name
}