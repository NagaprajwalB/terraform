variable "instances" {
  description = "Map of EC2 instances with settings"
  default = {
    "instance1" = {
      ami           = "ami-0ec10929233384c7f"
      instance_type = "t2.micro"
    },
    "instance2" = {
      ami           = "ami-0ec10929233384c7f"
      instance_type = "t3.micro"
    }
  }
}
