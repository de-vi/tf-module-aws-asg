variable "ecs_optimized_type" {
  description = "Type of ECS image to use"
  default     = "amzn2"
}

variable "ami_filter" {
  description = "The filter used to select the ECS AMI. amzn2-ami-ecs-hvm-2.0.????????-x86_64-ebs is the default pattern"
  type        = list(map(string))

  default = [
    {
      name   = "name"
      values = "amzn2-ami-ecs-hvm-2.0.????????-x86_64-ebs"
    },
  ]
}

variable "ami_latest" {
  description = "Indicator to use the latest avaiable in the the list of the AMI's for the ECS cluster."
  type        = bool
  default     = true
}

variable "ami_owners" {
  description = "A list of owners used to select the AMI for the ECS cluster."
  type        = list(string)
  default     = ["amazon"]
}

variable "name" {
  description = "Common name for resources"
  type        = string
  default     = ""
}

variable "security_group_id" {
  description = "Security group id"
  type        = string
  default     = ""
}

variable "image_id" {
  description = "Image id"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = ""
}

variable "sg_id" {
  description = "Security group id"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data for instances"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "Instance profile for EC2"
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "Associate public ip address when subnet id is attached to an internet gateway"
  type        = bool
  default     = false
}

variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 1
}

variable "tags" {}
variable "subnet_ids" {}

variable "target_group_arn" {}

variable "key_public_material" {}
