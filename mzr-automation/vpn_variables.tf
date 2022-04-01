###################################################################################################
###################################################################################################
#####           This Terraform file defines the variables used in VPN Modules                ######
#####                                 VPN Modules                                            ######
###################################################################################################
###################################################################################################

/**
* Name: vpn_mode
* Desc: Mode in VPN gateway. Supported values are route or policy. User should make the configuration updations on their onprem side VPN accordingly on the basis of IBM side VPN.
* Type: string
**/
variable "vpn_mode" {
  description = "Mode in VPN gateway. Supported values are route or policy."
  type        = string
  validation {
    condition     = contains(["route", "policy"], var.vpn_mode)
    error_message = "Error: Incorrect value for VPN gateway Mode. Allowed values are route and policy."
  }
}

/**
* Name: peer_cidrs
* Desc: List of peer CIDRs for the creation of VPN connection. IBM VPC CIDR and User’s on-prem subnet CIDR should NOT overlap if VPN is being used.
* Type: list(any)
**/
variable "peer_cidrs" {
  description = "List of peer CIDRs for the creation of VPN connection."
  type        = list(string)
  validation {
    condition     = can([for ip in var.peer_cidrs : regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([9]|1[0-9]|2[0-9]|3[0-2])$", ip)])
    error_message = "Error: Invalid IP address format provided. Check the peer_cidrs values. The value of the subnet mask should be in range [9-32]."
  }
}

/**
* Name: peer_gateway_ip
* Desc: The IP address of the peer VPN gateway.
* Type: string
**/
variable "peer_gateway_ip" {
  description = "The IP address of the peer VPN gateway."
  type        = string
  validation {
    condition     = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.peer_gateway_ip))
    error_message = "Error: Invalid IP address format provided. Check the peer_gateway_ip value."
  }
}

/**
* Name: preshared_key
* Desc: The Key configured on the peer gateway. The key is usually a complex string similar to a password.
* Type: string
**/
variable "preshared_key" {
  description = "The Key configured on the peer gateway. The key is usually a complex string similar to a password."
  type        = string
  sensitive   = true
}

/**
* Name: action
* Desc: Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none
* Type: string
**/
variable "action" {
  description = "Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none"
  type        = string
  default     = "none"
}

/**
* Name: admin_state_up
* Desc: The VPN gateway connection status. If set to false, the VPN gateway connection is shut down
* Type: bool
**/
variable "admin_state_up" {
  description = "The VPN gateway connection status. If set to false, the VPN gateway connection is shut down."
  type        = bool
  default     = "true"
}

/**
* Name: interval
* Desc: Dead peer detection interval in seconds. How often to test that the peer gateway is responsive.
* Type: number
**/
variable "interval" {
  description = "Dead peer detection interval in seconds. How often to test that the peer gateway is responsive."
  type        = number
  default     = 30
  validation {
    condition     = var.interval >= 1 && var.interval <= 86399
    error_message = "Error: Incorrect value for timeout. Allowed value should be between 1 and 86399."
  }
}

/**
* Name: timeout
* Desc: Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1.
* Type: number
**/
variable "timeout" {
  description = "Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1."
  type        = number
  default     = 120
  validation {
    condition     = var.timeout >= 2 && var.timeout <= 86399
    error_message = "Error: Incorrect value for timeout. Allowed value should be between 2 and 86399."
  }
}

/**
* Name: authentication_algorithm
* Desc: Enter the algorithm that you want to use to authenticate IPSec peers. Available options are md5, sha1, or sha256
* Type: string
**/
variable "authentication_algorithm" {
  description = "Enter the algorithm that you want to use to authenticate IPSec peers. Available options are md5, sha1, sha256, or sha512"
  type        = string
  default     = "md5"
  validation {
    condition     = contains(["md5", "sha1", "sha256", "sha512"], var.authentication_algorithm)
    error_message = "Error: Incorrect value for authentication_algorithm. Allowed values are md5, sha1, sha256, or sha512."
  }
}

/**
* Name: encryption_algorithm
* Desc: Enter the algorithm that you want to use to encrypt data. Available options are: triple_des, aes128, or aes256
* Type: string
**/
variable "encryption_algorithm" {
  description = "Enter the algorithm that you want to use to encrypt data. Available options are: triple_des, aes128, or aes256"
  type        = string
  default     = "triple_des"
  validation {
    condition     = contains(["triple_des", "aes128", "aes256"], var.encryption_algorithm)
    error_message = "Error: Incorrect value for encryption_algorithm. Allowed values are triple_des, aes128, or aes256."
  }
}

/**
* Name: key_lifetime
* Desc: The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated.
* Type: map(number)
**/
variable "key_lifetime" {
  description = "The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated."
  type        = map(number)
  default = {
    "ike"   = 28800
    "ipsec" = 3600
  }
}

/**
* Name: dh_group
* Desc: Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 2, 5, 14, or 19
* Type: number
**/
variable "dh_group" {
  description = "Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 2, 5, 14, or 19"
  type        = number
  default     = 2
  validation {
    condition     = contains([2, 5, 14, 19], var.dh_group)
    error_message = "Error: Incorrect value for dh_group. Allowed values are 2, 5, 14, or 19."
  }
}

/**
* Name: ike_version
* Desc: Enter the IKE protocol version that you want to use. Available options are 1, or 2
* Type: number
**/
variable "ike_version" {
  description = "Enter the IKE protocol version that you want to use. Available options are 1, or 2"
  type        = number
  default     = 2
  validation {
    condition     = contains([1, 2], var.ike_version)
    error_message = "Error: Incorrect value for ike_version. Allowed values are 1, or 2."
  }
}

/**
* Name: perfect_forward_secrecy
* Desc: Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group_2, group_5, and group_14
* Type: string
**/
variable "perfect_forward_secrecy" {
  description = "Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group_2, group_5, and group_14"
  type        = string
  default     = "disabled"
  validation {
    condition     = contains(["disabled", "group_2", "group_5", "group_14"], var.perfect_forward_secrecy)
    error_message = "Error: Incorrect value for perfect_forward_secrecy. Allowed values are disabled, group_2, group_5, and group_14."
  }
}