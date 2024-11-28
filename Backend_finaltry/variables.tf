variable "rg_backend_ptj_name" {
  type        = string
  description = "Name of the resource group for the backend"
}

variable "rg_backend_ptj_location" {
  type        = string
  default     = "west europe"
  description = "Location of the resource group"
}

variable "sa_backend_ptj" {
  type        = string
  description = "Name of the storrage account for the backend"
}

variable "sc_backend_ptj" {
  type        = string
  description = "Name of the storrage container for the backend"
}

variable "kv_backend_ptj_name" {
  type        = string
  description = "Name of the KeyVault for the backend"
}

variable "sa_backend_ptj_accesskey_name" {
  type        = string
  description = "Name of the storage access key for the backend"
}
