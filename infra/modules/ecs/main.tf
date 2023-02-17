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
  family       = "gpu-worker"
  cpu          = 512
  memory       = 512
  # network_mode ="awsvpc"
  task_role_arn      = aws_iam_role.task_execution_role.arn
  execution_role_arn = aws_iam_role.ecs_agent_execution_role.arn
  container_definitions = data.template_file.task_definition_template.rendered
  requires_compatibilities = ["EC2"]
}

data "template_file" "task_definition_template" {
    template = file("${var.root_app_path}/infra/modules/ecs/task_definition.json")
    vars = {
      REGION = var.region
      REPOSITORY_URL = replace(var.repository_url, "https://", "")
    }
}

