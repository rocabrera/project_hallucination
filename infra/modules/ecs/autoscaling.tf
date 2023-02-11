resource "aws_launch_template" "ecs_launch_template" {
    name_prefix          = "protein-design"
    instance_type        = "t2.micro"
    image_id             = var.image_id
    security_groups      = [aws_security_group.ecs_sg.id]
    iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config"
}

resource "aws_autoscaling_group" "asg" {
    name_prefix                      = "asg-protein-design"
    vpc_zone_identifier       = [aws_subnet.pub_subnet.id]
    
    launch_template {
        id      = aws_launch_template.foobar.id
        version = aws_launch_template.ecs_launch_template.latest_version
    }

    desired_capacity          = 1
    min_size                  = 1
    max_size                  = 1
    health_check_grace_period = 300
    health_check_type         = "EC2"
}