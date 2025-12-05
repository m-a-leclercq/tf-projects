output "project_credentials" {
  description = "Project user credentials"
  value = {
    for project in local.projects : project => {
      username = elasticstack_elasticsearch_security_user.project_user[project].username
      password = nonsensitive(random_password.project_password[project].result)
      space_id = elasticstack_kibana_space.project_space[project].space_id
      role     = elasticstack_elasticsearch_security_role.project_role[project].name
    }
  }
}
