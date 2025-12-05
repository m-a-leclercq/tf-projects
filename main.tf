
# Define projects
locals {
  projects = ["B", "C"]
}

# Generate random passwords for each project user
resource "random_password" "project_password" {
  for_each = toset(local.projects)

  length  = 20
  special = true
}

# Create Kibana Spaces for each project
resource "elasticstack_kibana_space" "project_space" {
  for_each = toset(local.projects)

  space_id    = "project${lower(each.value)}"
  name        = "Project ${each.value}"
  description = "Dedicated space for Project ${each.value}"
}

# Create roles for each project
resource "elasticstack_elasticsearch_security_role" "project_role" {
  for_each = toset(local.projects)

  name = "project${lower(each.value)}_role"

  indices {
    names      = ["logs-*-project${lower(each.value)}*"]
    privileges = ["read", "write", "create_index", "view_index_metadata"]
  }

  indices {
    names      = ["metrics-*-project${lower(each.value)}*"]
    privileges = ["read", "write", "create_index", "view_index_metadata"]
  }

  indices {
    names      = ["traces-*-project${lower(each.value)}*"]
    privileges = ["read", "write", "create_index", "view_index_metadata"]
  }

  applications {
    application = "kibana-.kibana"
    privileges  = ["feature_discover.all", "feature_dashboard.all", "feature_visualize.all", "feature_canvas.all", "feature_maps.all", "feature_ml.all", "feature_graph.all", "feature_apm.all", "feature_indexPatterns.all", "feature_savedObjectsManagement.all", "feature_dev_tools.all", "feature_advancedSettings.all"]
    resources   = ["space:${elasticstack_kibana_space.project_space[each.value].space_id}"]
  }
}

# Create native users for each project
resource "elasticstack_elasticsearch_security_user" "project_user" {
  for_each = toset(local.projects)

  username      = "project${lower(each.value)}"
  password      = random_password.project_password[each.value].result
  roles         = [elasticstack_elasticsearch_security_role.project_role[each.value].name]
  full_name     = "Project ${each.value} User"
  email         = "project${lower(each.value)}@example.com"
}
