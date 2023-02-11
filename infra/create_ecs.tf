# module "ecs" {
#     source         = "./modules/ecs"
#     region         = var.region
#     account_id     = var.account_id
#     environment    = var.environment
#     image_id       = module.docker_image.image_id

#     depends_on = [
#       module.docker_image
#     ]
# }
