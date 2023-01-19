#provider -region
variable "region" {
  default     = "eu-west-2"
  description = "Variable for VPC region"
  type        = string
}

#vpc name
variable "vpc" {
  default     = "Nkabom-web"
  description = "variable for vpc name"
  type        = string
}

# vpc-cidr
variable "vpc-cidr" {
  default     = "10.0.0.0/16"
  description = "variable for vpc cidr block"
  type        = string
}

# vpc-dns-hostnames
variable "dnshostnames" {
  default     = true
  description = "variable for dns hostname enabling"
  type        = bool
}

# vpc-dns-support
variable "dnssupport" {
  default     = true
  description = "variable for dns support enabling"
  type        = bool
}

/************************************************SUBNETS**********************************************************/

# Subnet 1
# subnet-1 cidr
variable "publicsubnet1-cidr" {
  default     = "10.0.1.0/24"
  description = "variable for public subnet 1 cidr block"
  type        = string
}


# availability zone
variable "AZ-1" {
  default     = "eu-west-2a"
  description = "availability zone 1"
  type        = string
}

# map ip on launch
variable "launch-ip" {
  default     = true
  description = "availability 1"
  type        = bool
}


variable "publicsubnet2-cidr" {
  default     = "10.0.2.0/24"
  description = "variable for public subnet 2 cidr block"
  type        = string
}

# availability zone
variable "AZ-2" {
  default     = "eu-west-2b"
  description = "availability zone 2"
  type        = string
}


# Private - map ip on launch
variable "priv-launch-ip" {
  default     = false
  description = "variable for map public ip on launch for private subnets"
  type        = bool
}


variable "privatesubnet1-cidr" {
  default     = "10.0.3.0/24"
  description = "variable for private subnet 1 cidr block"
  type        = string
}

variable "privatesubnet2-cidr" {
  default     = "10.0.4.0/24"
  description = "variable for private subnet 2 cidr block"
  type        = string
}


/************************************************ Security groups*************************************************/

# Security group ingress rule - front end
variable "frontend_port" {
  default     = "80"
  description = "Port exposed by the docker image to redirect traffic to"
  type        = string
}

# Security group ingress rule - backend end
variable "backend_port" {
  default     = "443"
  description = "Port exposed by the docker image to redirect traffic to"
  type        = string
}


/***************************************************ECS-FARGATE***********************************************************/
variable "fargate_cpu" {
  default     = "1024"
  description = "fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}

variable "fargate_memory" {
  default     = "2048"
  description = "fargate instance memory to provision (in MiB)"
}

variable "app_count" {
  default     = "4"
  description = "Number of docker containers to run"
}

variable "ecs_task_execution_role_name" {
  default     = "ECS-ROLE"
  description = "ecs task execution role name"
}


/**********************************************Database***********************************************************/

variable "password" {
  default     = "admin1234"
  description = "password for rds instance"
}

variable "tags" {
  default     = "PROD"
  description = "Variable for Tag in different environmets"
}


