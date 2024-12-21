variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "ami" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "instance_name" {
  type        = string
}

variable "instance_profile" {
  type        = string
}
