resource "aws_ecs_cluster" "ecs_cluster" {
    name  = "protein-design"
}

resource "aws_ecs_service" "worker" {
  name            = "gpu-worker"
  launch_type     = "EC2"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
}

resource "aws_ecs_task_definition" "task_definition" {
  family               =  "gpu-worker"
  container_definitions = data.template_file.task_definition_template.rendered
}

data "template_file" "task_definition_template" {
    template = file("${var.root_app_path}/infra/modules/ecs/task_definition.json")
    vars = {
      REPOSITORY_URL = var.repository_url
    }
}

