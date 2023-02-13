resource "aws_launch_template" "ecs_launch_template" {
    name_prefix          = "protein-design"
    instance_type        = "t3.micro"
    # TODO: Get automatically later & maybe changing to amazon linux image
    image_id             = "ami-0557a15b87f6559cf" 
    user_data            = filebase64("${var.root_app_path}/infra/modules/ecs/user_data.sh")
    network_interfaces {
        security_groups      = [aws_security_group.ecs_sg.id]
    }
    iam_instance_profile {
        name = aws_iam_instance_profile.ecs_agent.name
    }
}

resource "aws_autoscaling_group" "asg" {
    name_prefix               = "asg-protein-design"
    vpc_zone_identifier       = [aws_subnet.pub_subnet.id]
    
    launch_template {
        id      = aws_launch_template.ecs_launch_template.id
        version = aws_launch_template.ecs_launch_template.latest_version
    }

    desired_capacity          = 1
    min_size                  = 1
    max_size                  = 1
    health_check_grace_period = 300
    health_check_type         = "EC2"
}