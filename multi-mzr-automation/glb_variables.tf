###################################################################################################
###################################################################################################
#####        This Terraform file defines the variables used in GLB Group Module              ######
#####                                    GLB Group Module                                    ######
###################################################################################################
###################################################################################################

/**
* Name: glb_domain_name
* Type: String
* Description: Domain name to be used with global load balancer
*/
variable "glb_domain_name" {
  description = "Domain name to be used with global load balancer"
  type        = string
}

/**
* Name: glb_traffic_steering
* Type: String
* Description: GLB traffic Steering Policy which allows off, geo, random, dynamic_latency
*/
variable "glb_traffic_steering" {
  description = "GLB traffic Steering Policy which allows off,geo,random,dynamic_latency"
  type        = string
  validation {
    condition     = contains(["off", "geo", "random", "dynamic_latency"], var.glb_traffic_steering)
    error_message = "Error: Incorrect value for glb_traffic_steering. Allowed values are off, geo, random, dynamic_latency."
  }
}

/**
  GLB Region Code	 GLB Region Name
      EEU	         Eastern Europe
      ENAM         Eastern North America
      ME	         Middle East
      NAF	         Northern Africa
      NEAS      	 Northeast Asia
      NSAM      	 Northern South America
      OC        	 Oceania
      SAF	         Southern Africa
      SAS	         Southern Asia
      SEAS	       Southeast Asia
      SSAM	       Southern South America
      WEU	         Western Europe
      WNAM	       Western North America
*/
variable "glb_region1_code" {
  description = "Enter the Region code for GLB Geo Routing for Region 1 Pool: \nRegion Code -> Region Name \nEEU -> Eastern Europe \nENAM -> Eastern North America \nME -> Middle East \nNAF -> Northern Africa \nNEAS -> Northeast Asia \nNSAM -> Northern South America \nOC -> Oceania \nSAF -> Southern Africa \nSAS -> Southern Asia \nSEAS -> Southeast Asia \nSSAM -> Southern South America \nWEU -> Western Europe \nWNAM -> Western North America"
  type        = string
  validation {
    condition     = contains(["EEU", "ENAM", "ME", "NAF", "NEAS", "NSAM", "OC", "SAF", "SAS", "SEAS", "SSAM", "WEU", "WNAM"], var.glb_region1_code)
    error_message = "Error: Incorrect value for GLB Region Code."
  }
}

variable "glb_region2_code" {
  description = "Enter the Region code for GLB Geo Routing for Region 2 Pool: \nRegion Code -> Region Name \nEEU -> Eastern Europe \nENAM -> Eastern North America \nME -> Middle East \nNAF -> Northern Africa \nNEAS -> Northeast Asia \nNSAM -> Northern South America \nOC -> Oceania \nSAF -> Southern Africa \nSAS -> Southern Asia \nSEAS -> Southeast Asia \nSSAM -> Southern South America \nWEU -> Western Europe \nWNAM -> Western North America"
  type        = string
  validation {
    condition     = contains(["EEU", "ENAM", "ME", "NAF", "NEAS", "NSAM", "OC", "SAF", "SAS", "SEAS", "SSAM", "WEU", "WNAM"], var.glb_region2_code)
    error_message = "Error: Incorrect value for GLB Region Code."
  }
}

/**
* Name: cis_glb_plan
* Desc: Plan to be used for CIS instance for GLB
* Type: string
**/
variable "cis_glb_plan" {
  description = "Plan to be used for CIS instance for GLB"
  type        = string
  default     = "standard"
}

/**
* Name: cis_glb_location
* Desc: Location to be used for CIS instance for GLB
* Type: string
**/
variable "cis_glb_location" {
  description = "Location to be used for CIS instance for GLB"
  type        = string
  default     = "global"
}

/**
* Name: glb_proxy_enabled
* Desc: Global loadbalancer proxy state
* Type: string
**/
variable "glb_proxy_enabled" {
  description = "Global loadbalancer proxy state"
  type        = string
  default     = "true"
}

/**
* Name: expected_codes
* Desc: The expected HTTP response code or code range of the health check
* Type: string
**/
variable "expected_codes" {
  description = "The expected HTTP response code or code range of the health check"
  type        = string
  default     = "2xx"
}

/**
* Name: expected_body
* Desc: A case-insensitive sub-string to look for in the response body. If this string is not found, the origin will be marked as unhealthy. 
*       A null value of "" is allowed to match on any content
* Type: string
**/
variable "expected_body" {
  description = "A case-insensitive sub-string to look for in the response body. If this string is not found, the origin will be marked as unhealthy. A null value of “” is allowed to match on any content"
  type        = string
  default     = ""
}

/**
* Name: glb_healthcheck_method
* Desc: Method to be used for GLB health check
* Type: string
**/
variable "glb_healthcheck_method" {
  description = "Method to be used for GLB health check"
  type        = string
  default     = "GET"
  validation {
    condition     = contains(["GET", "HEAD"], var.glb_healthcheck_method)
    error_message = "Error: Incorrect value for glb_healthcheck_method. Allowed values are GET or HEAD."
  }
}

/**
* Name: glb_healthcheck_timeout
* Desc: The timeout in seconds before marking the health check as failed
* Type: number
**/
variable "glb_healthcheck_timeout" {
  description = "The timeout in seconds before marking the health check as failed"
  type        = number
  default     = 7
  validation {
    condition     = var.glb_healthcheck_timeout >= 1 && var.glb_healthcheck_timeout <= 10
    error_message = "Error: Incorrect value for glb_healthcheck_timeout. Allowed value should be between 1 and 10."
  }
}

/**
* Name: glb_healthcheck_path
* Desc: The endpoint path to health check against
* Type: string
**/
variable "glb_healthcheck_path" {
  description = "The endpoint path to health check against"
  type        = string
  default     = "/"
}

/**
* Name: glb_protocol_type
* Desc: The protocol to use for the health check.
* Type: string
**/
variable "glb_protocol_type" {
  description = "The protocol to use for the health check"
  type        = string
  default     = "http"
}

/**
* Name: interval
* Desc: The interval between each health check. Shorter intervals may improve failover time, but will increase load on the origins as we check from multiple locations
* Type: number
**/
variable "interval" {
  description = "The interval between each health check. Shorter intervals may improve failover time, but will increase load on the origins as we check from multiple locations"
  type        = number
  default     = 60
  validation {
    condition     = var.interval >= 60 && var.interval <= 3600
    error_message = "Error: Incorrect value for interval. Allowed value should be between 60 and 3600."
  }
}

/**
* Name: retries
* Desc: The number of retries to attempt in case of a timeout before marking the origin as unhealthy
* Type: number
**/
variable "retries" {
  description = "The number of retries to attempt in case of a timeout before marking the origin as unhealthy"
  type        = number
  default     = 3
  validation {
    condition     = var.retries >= 1 && var.retries <= 3
    error_message = "Error: Incorrect value for retries. Allowed value should be between 1 and 3."
  }
}

/**
* Name: follow_redirects
* Desc: If set to true, a redirect is followed when a redirect is returned by the origin pool. Is set to false, redirects from the origin pool are not followed
* Type: bool
**/
variable "follow_redirects" {
  description = "If set to true, a redirect is followed when a redirect is returned by the origin pool. Is set to false, redirects from the origin pool are not followed"
  type        = bool
  default     = "true"
}

/**
* Name: glb_healthcheck_port
* Desc: The TCP port number that you want to use for the health check.
* Type: number
**/
variable "glb_healthcheck_port" {
  description = "The TCP port number that you want to use for the health check."
  type        = number
  default     = 80
}

/**
* Name: allow_insecure
* Desc: If set to true, the certificate is not validated when the health check uses HTTPS. If set to false, 
* the certificate is validated, even if the health check uses HTTPS. The default value is false.
* Type: bool
**/
variable "allow_insecure" {
  description = "If set to true, the certificate is not validated when the health check uses HTTPS. If set to false, the certificate is validated, even if the health check uses HTTPS. The default value is false."
  type        = bool
  default     = "false"
}

/**
* Name: minimum_origins
* Desc: The minimum number of origins that must be healthy for the pool to serve traffic. If the number of healthy origins falls within this number, 
*       the pool will be marked unhealthy and we will failover to the next available pool
* Type: number
**/
variable "minimum_origins" {
  description = "The minimum number of origins that must be healthy for the pool to serve traffic. If the number of healthy origins falls within this number, the pool will be marked unhealthy and we will failover to the next available pool"
  type        = number
  default     = 1
}

/**
* Name: region1_pool_weight
* Desc: The origin pool-1 weight.
* Type: bool
**/
variable "region1_pool_weight" {
  description = "The origin pool-1 weight."
  type        = number
  default     = 1
  validation {
    condition     = contains([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], var.region1_pool_weight)
    error_message = "Error: Incorrect value for region1_pool_weight. Allowed values should be between 0 and 1."
  }
}

/**
* Name: region2_pool_weight
* Desc: The origin pool-2 weight.
* Type: bool
**/
variable "region2_pool_weight" {
  description = "The origin pool-2 weight."
  type        = number
  default     = 1
  validation {
    condition     = contains([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], var.region2_pool_weight)
    error_message = "Error: Incorrect value for region2_pool_weight. Allowed values should be between 0 and 1."
  }
}

/**
* Name: notification_email
* Desc: The Email address to send health status notifications to. This can be an individual mailbox or a mailing list.
* Type: string
**/
variable "notification_email" {
  description = "The Email address to send health status notifications to. This can be an individual mailbox or a mailing list."
  type        = string
}
