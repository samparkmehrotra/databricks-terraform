
data "databricks_node_type" "smallest" {
  local_disk = true
  provider   = databricks.created_workspace
  depends_on = [databricks_mws_workspaces.this]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  provider          = databricks.created_workspace
  depends_on        = [databricks_mws_workspaces.this]
}

resource "databricks_cluster" "single_node" {
  provider                = databricks.created_workspace
  depends_on              = [databricks_mws_workspaces.this]
  cluster_name            = "Single Node"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20

  spark_conf = {
    # Single-node
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }
  
}
