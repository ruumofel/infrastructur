variable "aws_access_key" {
    default = "AKIAX65PN55OSXTGZ3PR"
}

variable "aws_secret_key" {
    default = "hvjuIEKPtyaubD1YelWRD9SypAalyrtCbersSLRK"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "availability_zone" {
    default = "ap-southeast-1a"
}

variable "ami" {
    default = "ami-055d15d9cfddf7bd3"
}

variable "instance_type" {
    default = "t2.medium"
}

variable "root_volume_size" {
    default = 8 
}

variable "instance_count" {
    default = 1
}

variable "delete_on_termination" {
    default = true
}

variable "volume_size" {
    default = 20
}

variable "volume_type" {
    default = "gp2"
}

variable "key_name" {
    default = "halo"
}

variable "vpc_security_group_ids" {
    default = ["sg-092a395bc553d737b"]
}

variable "associate_public_ip_address" {
    default = true
}

variable "tags" {
    type = map(string)
    default = {
        "name" = "jenkins"
        "purpose" = "Projeck-sekolah-devops"
        "env" = "prod"
    }
}