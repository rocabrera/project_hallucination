module "ecs" {
    source         = "./modules/ecs"
    region         = var.region
    account_id     = var.account_id
    environment    = var.environment
    root_app_path  = local.root_app_path
    repository_url = module.docker_image.repository_url

    depends_on = [
      module.docker_image
    ]
}
