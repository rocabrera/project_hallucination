#cloud-boothook
#!/bin/bash
echo "ECS_CLUSTER=protein-design" >> /etc/ecs/ecs.config
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html
echo "ECS_ENABLE_GPU_SUPPORT=true" >> /etc/ecs/ecs.config
# The Amazon ECS GPU-optimized AMI has IPv6 enabled, which causes issues when using yum.
echo "ip_resolve=4" >> /etc/yum.conf


# sudo amazon-linux-extras disable docker
# sudo amazon-linux-extras install -y ecs; sudo systemctl enable --now ecs
start ecs
