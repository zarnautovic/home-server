variable "pm_api_url" {
  description = "The API URL for the Proxmox server"
  type        = string
}

variable "pm_api_token_secret" {
  description = "The secret part of the API token for Proxmox"
  type        = string
  sensitive   = true
}

variable "pm_api_token_id" {
  description = "The token ID for the Proxmox API"
  type        = string
}

variable "ssh_key" {
  description = "The SSH key for the Proxmox server"
  type        = string
}

variable "promox_ssh_key" {
  description = "The SSH key for the Proxmox server"
  type        = string
}