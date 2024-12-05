#create an ec2 instance 

resource "aws_instance" "utc-dev-inst" {
  ami = "ami-0195204d5dce06d99"
  ebs_block_device {
    device_name = "/dev/sda1"  # Default device name for the root volume
    volume_size = 20           # Size in GB
    volume_type = "gp2"        # General Purpose SSD (you can adjust the type if needed)
  }
  # security_groups = [aws_security_group.webserver-sg.name] 
  vpc_security_group_ids = [ aws_security_group.webserver-sg.id ]
  associate_public_ip_address = true
  key_name = "utc-key"
  subnet_id = aws_subnet.pub1.id
  user_data = file("userdata.sh")
  instance_type = "t2.micro" #add the instance type here
  
  tags = {
    Name = "utc-dev-inst"
    Team = "Cloud Transformation"
    Environment = "dev"
    Created-by = "Viviane D"
  }
}