# Main settings
variable "at" {
    type        = string
    default     = "mock"
    description = "Specify your DO access token."
    validation {
        condition     = length(var.at) > 0
        error_message = "The access token value must be set."
  }
}

variable "region" {
    type        = string
    default     = "fra1"
    description = "Region where all resources will be created. Default value fra1"
    validation {
        condition     = length(var.region) > 0
        error_message = "The region value must be set."
  }
}

variable "ssh_token" {
    type        = string
    default     = "mock"
    description = "Specify ssh access name for ssh connection"
    validation {
        condition     = length(var.ssh_token) > 0
        error_message = "The ssh_token value must be set."
  }
}

# DB group variables
variable "db_image" {
    type        = string
    default     = "centos-8-x64"
    description = "Which image will be used for deploing DB droplet"
  
}

variable "db_size" {
    type = string
    default = "s-4vcpu-8gb"
    description = "Size of future DB droplet"
  
}

variable "db_count" {
    default = 1
    description = "Count of web servers. Default value 1"
}


# Web group variables
variable "web_image" {
    type        = string
    default     = "ubuntu-18-04-x64"
    description = "Which image will be used for deploing WEB droplet"
  
}

variable "web_size" {
    type = string
    default = "s-1vcpu-1gb"
    description = "Size of future WEB droplet"
  
}

variable "web_count" {
    default = 2
    description = "Count of web servers. Default value 2"
}