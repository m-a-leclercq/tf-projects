
# Configure cluster settings
resource "elasticstack_elasticsearch_cluster_settings" "cluster_config" {
  persistent {
    setting {
      name  = "indices.breaker.total.limit"
      value = "60%"
    }

    setting {
      name  = "search.max_buckets"
      value = "20000"
    }
  }
}

# Create component templates with slow log settings
resource "elasticstack_elasticsearch_component_template" "logs_custom" {
  name = "logs@custom"

  template {
    settings = jsonencode({
      "index.search.slowlog.threshold.query.warn"    = "10s"
      "index.search.slowlog.threshold.query.info"    = "5s"
      "index.indexing.slowlog.threshold.index.warn"  = "10s"
      "index.indexing.slowlog.threshold.index.info"  = "5s"
    })
  }
}

resource "elasticstack_elasticsearch_component_template" "metrics_custom" {
  name = "metrics@custom"

  template {
    settings = jsonencode({
      "index.search.slowlog.threshold.query.warn"    = "10s"
      "index.search.slowlog.threshold.query.info"    = "5s"
      "index.indexing.slowlog.threshold.index.warn"  = "10s"
      "index.indexing.slowlog.threshold.index.info"  = "5s"
    })
  }
}

resource "elasticstack_elasticsearch_component_template" "traces_custom" {
  name = "traces@custom"

  template {
    settings = jsonencode({
      "index.search.slowlog.threshold.query.warn"    = "10s"
      "index.search.slowlog.threshold.query.info"    = "5s"
      "index.indexing.slowlog.threshold.index.warn"  = "10s"
      "index.indexing.slowlog.threshold.index.info"  = "5s"
    })
  }
}
