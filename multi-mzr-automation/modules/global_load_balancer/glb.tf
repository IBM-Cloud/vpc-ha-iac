/**
#################################################################################################################
*                           Resources section for the Global LoadBalancer Module.
*                                 Start Here for the Resources Section 
#################################################################################################################
*/

/**
* CIS Instance
* Element : ibm_cis
* This resource will be used to create a CIS instance for GLB.
**/

resource "ibm_cis" "cis_instance" {
  name              = "${var.prefix}cis-instance"
  plan              = var.cis_glb_plan
  resource_group_id = var.resource_group_id
  tags              = ["${var.prefix}glb"]
  location          = var.cis_glb_location

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

/**
* CIS Domain
* Element : ibm_cis_domain
* This resource creates a DNS Domain resource that represents a DNS domain assigned to Cloud Internet Services (CIS)
**/

resource "ibm_cis_domain" "glb_domain" {
  domain = var.glb_domain_name
  cis_id = ibm_cis.cis_instance.id
}

/**
* CIS Origin Pool
* Element : ibm_cis_origin_pool
* This resource creates a pool of origins that can be used by a IBM CIS Global Load Balancer
**/
resource "ibm_cis_origin_pool" "region1_pool" {
  cis_id  = ibm_cis.cis_instance.id
  name    = "${var.prefix}pool-${var.region1}"
  monitor = ibm_cis_healthcheck.region1_healthcheck.id
  origins {
    name    = "${var.prefix}lb-${var.region1}"
    address = var.web_lb_ip_region1
    enabled = true
    weight  = var.region1_pool_weight
  }
  notification_email = var.notification_email
  description        = "${var.prefix}pool-${var.region1}"
  enabled            = true
  minimum_origins    = var.minimum_origins
  check_regions      = [var.glb_region1_code]
}

/**
* CIS Origin Pool
* Element : ibm_cis_origin_pool
* This resource creates a pool of origins that can be used by a IBM CIS Global Load Balancer
**/
resource "ibm_cis_origin_pool" "region2_pool" {
  cis_id  = ibm_cis.cis_instance.id
  name    = "${var.prefix}pool-${var.region2}"
  monitor = ibm_cis_healthcheck.region2_healthcheck.id
  origins {
    name    = "${var.prefix}lb-${var.region2}"
    address = var.web_lb_ip_region2
    enabled = true
    weight  = var.region2_pool_weight
  }
  notification_email = var.notification_email
  description        = "${var.prefix}pool-${var.region2}"
  enabled            = true
  minimum_origins    = var.minimum_origins
  check_regions      = [var.glb_region2_code]
}

/**
* CIS Global Load Balancer
* Element : ibm_cis_global_load_balancer
* This resource directs traffic to available origins and provides various options for geographically-aware 
* load balancing. This resource is associated with an IBM Cloud Internet Services instance, a CIS Domain resource 
* and CIS Origin pool resources.
**/
resource "ibm_cis_global_load_balancer" "glb" {
  cis_id    = ibm_cis.cis_instance.id
  domain_id = ibm_cis_domain.glb_domain.id
  name      = var.glb_domain_name
  // The ID of the pool to use when all other pools are considered unhealthy
  fallback_pool_id = ibm_cis_origin_pool.region1_pool.id
  // A list of pool IDs that are ordered by their failover priority.
  default_pool_ids = [ibm_cis_origin_pool.region1_pool.id, ibm_cis_origin_pool.region2_pool.id]
  description      = "Global Load Balancer which directs traffic to defined origin pools"
  proxied          = var.glb_proxy_enabled
  steering_policy  = var.glb_traffic_steering
  enabled          = true
  // A set of containing mappings of region and country codes to the list of pool of IDs. IDs are ordered by their failover priority.
  region_pools {
    region   = var.glb_region1_code
    pool_ids = [ibm_cis_origin_pool.region1_pool.id]
  }
  region_pools {
    region   = var.glb_region2_code
    pool_ids = [ibm_cis_origin_pool.region2_pool.id]
  }
}

/**
* CIS Health Check
* Element : ibm_cis_healthcheck
* This resource configures a health check monitor to actively check the availability of those servers.
**/
resource "ibm_cis_healthcheck" "region1_healthcheck" {
  cis_id           = ibm_cis.cis_instance.id
  expected_body    = var.expected_body
  expected_codes   = var.expected_codes
  method           = var.glb_healthcheck_method
  timeout          = var.glb_healthcheck_timeout
  path             = var.glb_healthcheck_path
  type             = var.glb_protocol_type
  interval         = var.interval
  retries          = var.retries
  follow_redirects = var.follow_redirects
  allow_insecure   = var.allow_insecure
  port             = var.glb_healthcheck_port
  description      = "${var.prefix}healthcheck-${var.region1}"
}

/**
* CIS Health Check
* Element : ibm_cis_healthcheck
* This resource configures a health check monitor to actively check the availability of those servers.
**/
resource "ibm_cis_healthcheck" "region2_healthcheck" {
  cis_id           = ibm_cis.cis_instance.id
  expected_body    = var.expected_body
  expected_codes   = var.expected_codes
  method           = var.glb_healthcheck_method
  timeout          = var.glb_healthcheck_timeout
  path             = var.glb_healthcheck_path
  type             = var.glb_protocol_type
  interval         = var.interval
  retries          = var.retries
  follow_redirects = var.follow_redirects
  allow_insecure   = var.allow_insecure
  port             = var.glb_healthcheck_port
  description      = "${var.prefix}healthcheck-${var.region2}"
}