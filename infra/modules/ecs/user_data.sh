#cloud-boothook
#!/bin/bash
echo "ECS_CLUSTER=protein-design" >> /etc/ecs/ecs.config
# sudo amazon-linux-extras disable docker
# sudo amazon-linux-extras install -y ecs; sudo systemctl enable --now ecs
start ecs
