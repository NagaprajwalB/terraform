resource "aws_instance" "My-instance-1" {
        ami = var.my-ami
        instance_type = var.my-instance-type

    tags = {
      Name = "MY-EC2-Instance-1"
    }  
}

resource "aws_instance" "My-instance-2" {
        ami = var.my-ami
        instance_type = var.my-instance-type  

    tags = {
      Name = "MY-EC2-Instance-1"
    }  
}
