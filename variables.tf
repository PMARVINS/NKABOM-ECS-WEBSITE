#provider -region
variable "region" {
  description = "Variable for VPC region"
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

variable "subnet1_name" {
  default       = "Public Subnet 1"
  description = "name for public subnet 1"
} 

variable "subnet2_name" {
  default       = "Public Subnet 2"
  description = "name for public subnet 2"
} 

variable "igw_name" {
  default       = "Internet-Gateway"
  description = "name for Internet Gateway"
} 

variable "publicroute_name" {
  default       = "Public-rt"
  description = "name Public route table"
} 

variable "subnet3_name" {
  default       = "Public Subnet 3"
  description = "name for public subnet #3"
}

variable "subnet4_name" {
  default       = "Public Subnet 4"
  description = "name for public subnet #4"
}

# availability zone
variable "AZ-1" {
  default     = "eu-west-2a"
  description = "availability zone 1"
  type        = string
}

variable "eip_name" {
  default       = "eip"
  description = "name for eleastic IP"
} 

variable "privateroute_name" {
  default       = "private-routetable"
  description = "name for private route table"
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

variable "username" {
  default     = "admin"
  description = "username for rds instance"
}

variable "password" {
  default     = "admin1234"
  description = "password for rds instance"
}

variable "tags" {
  default     = "PROD"
  description = "Variable for Tag in different environmets"
}


variable "environment_name" {
   type        = string
}



#Variables for RDS
variable "rds_subnetgroup_name" {
  default = "db_subnetgroup"
}
variable "allocatedstorage" {
  default  = "20"
}
variable "db_name" {
  default = "mypostgres"  
}
variable "engine" {
  default = "postgres"
}
variable "engine_version" {
  default = "13.3"
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "db_port" {
  default = 5432
}
variable "storage_type" {
  default = "gp2"
}
variable "network_type" {
  default = "ipv4"
}