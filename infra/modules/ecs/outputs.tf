output "repository_url" {
  value = replace(var.repository_url, "https://", "")
}
