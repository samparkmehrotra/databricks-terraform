resource "databricks_mws_workspaces" "this" {
  provider       = databricks.mws
  account_id     = var.databricks_account_id
  aws_region     = var.region
  workspace_name = "development"
  #deployment_name = "development-dbs" # We have to comment it as it is been provided by databricks team

  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id
  depends_on               = [databricks_mws_credentials.this, databricks_mws_storage_configurations.this, databricks_mws_networks.this]
}

// export host to be used by other modules
output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

