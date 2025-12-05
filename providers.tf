terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "~> 0.11"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    endpoints = [ "https://localhost:9200" ]
    password = "changeme"
  }
  kibana {
    username  = "elastic"
    endpoints = [ "https://localhost:5601" ]
    password = "changeme"
  }
}
