/**
#################################################################################################################
*                           Variable Section for the VPN Module.
*                           Start Here for the Variable Section 
#################################################################################################################
*/

/**
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "Prefix for all the resources."
  type        = string
}
/**
* Name: resource_group_id
* Type: String
*/
variable "resource_group_id" {
  description = "Resource Group ID is used to seperate the resources in a group."
  type        = string
}

/**
* Name: vpc_id
* Type: String
* Description: This is the vpc id which will be used for vpn module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: subnet
* Type: string
* Description: Subnet in which VPN gateway will be created.
**/
variable "subnet" {
  description = "Subnet in which VPN gateway will be created."
  type        = string
}

/**
* Name: zones
* Desc: List of Availability Zones where VPN will be created
* Type: list(any)
**/
variable "zones" {
  description = "List of Availability Zones where VPN will be created"
  type        = list(any)
}

/**
* Name: vpn_mode
* Desc: Mode in VPN gateway. Supported values are route or policy. User should make the configuration updations on their onprem side VPN accordingly on the basis of IBM side VPN.
* Type: string
**/
variable "vpn_mode" {
  description = "Mode in VPN gateway. Supported values are route or policy."
  type        = string
}

/**
* Name: local_cidrs
* Desc: List of local CIDRs for the creation of VPN connection.
* Type: string
**/
variable "local_cidrs" {
  description = "List of local CIDRs for the creation of VPN connection."
  type        = list(any)
}

/**
* Name: peer_cidrs
* Desc: List of peer CIDRs for the creation of VPN connection. IBM VPC CIDR and User’s on-prem subnet CIDR should NOT overlap if VPN is being used.
* Type: list(any)
**/
variable "peer_cidrs" {
  description = "List of peer CIDRs for the creation of VPN connection."
  type        = list(any)
}

/**
* Name: peer_gateway_ip
* Desc: The IP address of the peer VPN gateway.
* Type: string
**/
variable "peer_gateway_ip" {
  description = "The IP address of the peer VPN gateway."
  type        = string
}

/**
* Name: preshared_key
* Desc: The Key configured on the peer gateway. The key is usually a complex string similar to a password.
* Type: string
**/
variable "preshared_key" {
  description = "The Key configured on the peer gateway. The key is usually a complex string similar to a password."
  type        = string
}

/**
* Name: action
* Desc: Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none
* Type: string
**/
variable "action" {
  description = "Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none"
  type        = string
}

/**
* Name: admin_state_up
* Desc: The VPN gateway connection status. If set to false, the VPN gateway connection is shut down
* Type: bool
**/
variable "admin_state_up" {
  description = "The VPN gateway connection status. If set to false, the VPN gateway connection is shut down."
  type        = bool
}

/**
* Name: interval
* Desc: Dead peer detection interval in seconds. How often to test that the peer gateway is responsive.
* Type: number
**/
variable "interval" {
  description = "Dead peer detection interval in seconds. How often to test that the peer gateway is responsive."
  type        = number
}

/**
* Name: timeout
* Desc: Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1.
* Type: number
**/
variable "timeout" {
  description = "Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1."
  type        = number
}

/**
* Name: authentication_algorithm
* Desc: Enter the algorithm that you want to use to authenticate IPSec peers. Available options are md5, sha1, or sha256
* Type: string
**/
variable "authentication_algorithm" {
  description = "Enter the algorithm that you want to use to authenticate IPSec peers. Available options are md5, sha1, or sha256"
  type        = string
}

/**
* Name: encryption_algorithm
* Desc: Enter the algorithm that you want to use to encrypt data. Available options are: triple_des, aes128, or aes256
* Type: string
**/
variable "encryption_algorithm" {
  description = "Enter the algorithm that you want to use to encrypt data. Available options are: triple_des, aes128, or aes256"
  type        = string
}

/**
* Name: key_lifetime
* Desc: The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated.
* Type: map(number)
**/
variable "key_lifetime" {
  description = "The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated."
  type        = map(number)
}

/**
* Name: dh_group
* Desc: Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 2, 5, 14, or 19
* Type: number
**/
variable "dh_group" {
  description = "Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 2, 5, 14, or 19"
  type        = number
}

/**
* Name: ike_version
* Desc: Enter the IKE protocol version that you want to use. Available options are 1, or 2
* Type: number
**/
variable "ike_version" {
  description = "Enter the IKE protocol version that you want to use. Available options are 1, or 2"
  type        = number
}

/**
* Name: perfect_forward_secrecy
* Desc: Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group_2, group_5, and group_14
* Type: string
**/
variable "perfect_forward_secrecy" {
  description = "Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group_2, group_5, and group_14"
  type        = string
}

/**
* Name: tags
* Type: list
* Description: Enter any tags that you want to associate with your VPN. Tags might help you find your VPN more easily after it is created. Separate multiple tags with a comma (,).
*/
variable "tags" {
  description = "Enter any tags that you want to associate with your VPN. Tags might help you find your VPN more easily after it is created. Separate multiple tags with a comma (,)"
  type        = list(any)
  default     = null
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/