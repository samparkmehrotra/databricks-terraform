// initialize provider in normal mode
provider "databricks" {
  alias    = "created_workspace"
  host     = databricks_mws_workspaces.this.workspace_url
  username = var.databricks_account_username
  password = var.databricks_account_password
}

// create PAT token to provision entities within workspace
resource "databricks_token" "pat" {
  provider         = databricks.created_workspace
  comment          = "Terraform Provisioning"
  lifetime_seconds = 86400
}

// export token for integration tests to run on
output "databricks_token" {
  value     = databricks_token.pat.token_value
  sensitive = true
}
