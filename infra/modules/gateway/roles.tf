resource "aws_iam_role" "gateway" {
  name = "apigateway_role"

  assume_role_policy = data.aws_iam_policy_document.gateway_assume_role_policy.json

  inline_policy {
    name   = "cloudwatch-policy"
    policy = data.aws_iam_policy_document.cloudwatch_policy.json
  }

  inline_policy {
    name   = "sqs-policy"
    policy = data.aws_iam_policy_document.sqs_policy.json
  }

}