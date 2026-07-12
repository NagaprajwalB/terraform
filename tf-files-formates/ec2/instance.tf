resource "aws_instance" "My-instance" {
        ami = "ami-0ec10929233384c7f" 
        instance_type = "t3.micro"    
    tags = {
      Name = "MY-EC2-Instance"
    }  
}
