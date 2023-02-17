output predict_route {
    value = "https://${aws_api_gateway_rest_api.apigateway.id}.execute-api.${var.region}.amazonaws.com/${var.environment}/start-pipeline"
}