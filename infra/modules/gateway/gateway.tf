resource "aws_api_gateway_rest_api" "apigateway" {
  name        = "api-gateway-SQS"
  description = "POST records to SQS queue"
}

resource "aws_api_gateway_resource" "start_pipeline" {
    rest_api_id = aws_api_gateway_rest_api.apigateway.id
    parent_id   = aws_api_gateway_rest_api.apigateway.root_resource_id
    path_part   = "start-pipeline"
}

# resource "aws_api_gateway_request_validator" "validator_query" {
#   name                        = "queryValidator"
#   rest_api_id                 = aws_api_gateway_rest_api.apiGateway.id
#   validate_request_body       = false
#   validate_request_parameters = true
# }

resource "aws_api_gateway_method" "start_pipeline_method" {
    rest_api_id   = aws_api_gateway_rest_api.apigateway.id
    resource_id   = aws_api_gateway_resource.start_pipeline.id
    http_method   = "POST"
    authorization = "NONE"
}


resource "aws_api_gateway_integration" "api" {
  rest_api_id             = aws_api_gateway_rest_api.apigateway.id
  resource_id             = aws_api_gateway_resource.start_pipeline.id
  http_method             = aws_api_gateway_method.start_pipeline_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  credentials             = aws_iam_role.gateway.arn
  uri                     = "arn:aws:apigateway:${var.region}:sqs:path/${var.sqs_queue_name}"

  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
  }

  # Request Template for passing Method, Body, QueryParameters and PathParams to SQS messages
  request_templates = {
    "application/json" = <<EOF
Action=SendMessage&MessageBody={
  "method": "$context.httpMethod",
  "body-json" : $input.json('$'),
  "queryParams": {
    #foreach($param in $input.params().querystring.keySet())
    "$param": "$util.escapeJavaScript($input.params().querystring.get($param))" #if($foreach.hasNext),#end
  #end
  },
  "pathParams": {
    #foreach($param in $input.params().path.keySet())
    "$param": "$util.escapeJavaScript($input.params().path.get($param))" #if($foreach.hasNext),#end
    #end
  }
}"
EOF
  }
}