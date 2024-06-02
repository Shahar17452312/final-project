resource "aws_launch_template" "asg_launch_template" {
  name                   = "web_servers_lt"
  image_id               = local.app_ami
  key_name               = local.ec2_key_name
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.web_servers.id, aws_security_group.internal.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-servers"
    }
  }

  user_data = filebase64("${path.module}/userdate.sh")
}

resource "aws_autoscaling_group" "asg" {
  name                = "myASG"
  launch_template {
    id      = aws_launch_template.asg_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = module.vpc.public_subnets
  min_size            = 0
  max_size            = 2
  desired_capacity    = 2
  health_check_type   = "ELB"

  tag {
    key                 = "Name"
    value               = "myASG"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_alb_attachment_frontend" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = aws_lb_target_group.frontend1.arn
}

resource "aws_autoscaling_attachment" "asg_alb_attachment_backend" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = aws_lb_target_group.backend1.arn
}
