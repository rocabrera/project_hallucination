resource "aws_iam_role" "ecs_agent" {
  name               = "ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "ecs-agent"
  role = aws_iam_role.ecs_agent.name
}


resource "aws_iam_role" "task_execution_role" {
  name               = "task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_task_execution_policy.json
  inline_policy {
    name = "ecs-task-execution-policy"
    policy = data.aws_iam_policy_document.ecs_task_execution_policy.json
  }
}

