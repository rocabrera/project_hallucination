resource "aws_launch_template" "ecs_launch_template" {
    name_prefix          = "protein-design"
    instance_type        = "p2.xlarge"
    # image_id             = "ami-0ac7415dd546fb485" # ECS-optimized Amazon Linux 2
    image_id             = "ami-08ff414257e50e3e9" # ECS GPU-optimized 
    # user_data            = base64encode("#!/bin/bash\necho ECS_CLUSTER=default >> /etc/ecs/ecs.config")
    user_data            = filebase64("${var.root_app_path}/infra/modules/ecs/user_data.sh")
    network_interfaces {
        security_groups      = [aws_security_group.ecs_sg.id]
    }
    iam_instance_profile {
        name = aws_iam_instance_profile.ecs_agent.name
    }
}

# é possível pegar o AMI automaticamente via parameter store
# Parameters:
#   LatestECSOptimizedAMI:
#     Description: AMI ID
#     Type: AWS::SSM::Parameter::Value<AWS::EC2::Image::Id>
#     Default: /aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id

# resource "aws_launch_configuration" "ecs_launch_config" {
#     image_id             = "ami-0dfcb1ef8550277af"
#     iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
#     security_groups      = [aws_security_group.ecs_sg.id]
#     user_data            = "#!/bin/bash\necho ECS_CLUSTER=protein-design >> /etc/ecs/ecs.config"
#     instance_type        = "t2.micro"
# }



resource "aws_autoscaling_group" "asg" {
    name_prefix               = "asg-protein-design"
    vpc_zone_identifier       = [aws_subnet.pub_subnet.id]

    # launch_configuration = aws_launch_configuration.ecs_launch_config.name   
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