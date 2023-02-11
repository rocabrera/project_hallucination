data "aws_iam_policy_document" "gateway_assume_role_policy" {
  statement {

    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_policy" {
  statement {
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents",
        "logs:GetLogEvents",
        "logs:FilterLogEvents"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "sqs_policy" {
  statement {
    actions = [
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility",
        "sqs:ListDeadLetterSourceQueues",
        "sqs:SendMessageBatch",
        "sqs:PurgeQueue",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:GetQueueAttributes",
        "sqs:CreateQueue",
        "sqs:ListQueueTags",
        "sqs:ChangeMessageVisibilityBatch",
        "sqs:SetQueueAttributes"
    ]
    effect    = "Allow"
    resources = ["arn:aws:sqs:${var.region}:${var.account_id}:${var.sqs_queue_name}"]
  }
  statement {
    actions = [
        "sqs:ListQueues"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}


