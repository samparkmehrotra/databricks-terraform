data "databricks_node_type" "smallest_auto" {
  local_disk = true
  provider   = databricks.created_workspace
  depends_on = [databricks_mws_workspaces.this]
}

data "databricks_spark_version" "latest_lts_auto" {
  long_term_support = true
  provider          = databricks.created_workspace
  depends_on        = [databricks_mws_workspaces.this]
}

resource "databricks_cluster" "shared_autoscaling" {
  provider                = databricks.created_workspace
  depends_on              = [databricks_mws_workspaces.this]
  cluster_name            = "development-autoscaling-cluster"
  spark_version           = data.databricks_spark_version.latest_lts_auto.id
  node_type_id            = data.databricks_node_type.smallest_auto.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 2
  }
  spark_conf = {
    "spark.databricks.io.cache.enabled" : true,
    "spark.databricks.io.cache.maxDiskUsage" : "50g",
    "spark.databricks.io.cache.maxMetaDataCache" : "1g"
  }
  
}
