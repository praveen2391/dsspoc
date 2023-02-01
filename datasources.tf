# data "terraform_remote_state" "log" {
#   backend = "azurerm"

#   config = {
#     storage_account_name = var.storage_account_name
#     container_name = var.container_name
#     access_key = var.ARM_ACCESS_KEY
#     key = "log/s01.tfstateenv:s003"
#    }
# }