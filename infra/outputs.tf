# output "repository_url" {
#   value = module.ecs.repository_url
# }

output "repository_url" {
  value = module.gateway.predict_route
}
