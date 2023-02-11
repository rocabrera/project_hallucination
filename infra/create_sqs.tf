module "sqs" {
    source       = "./modules/sqs"
    region       = var.region
    account_id   = var.account_id
}
