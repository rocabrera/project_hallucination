module "docker_image" {
    source          = "./modules/docker_image"
    region          = var.region
    account_id      = var.account_id
    root_app_path   = local.root_app_path
    repository_name = "protein-design"
    image_tag       = "latest"
}
