#create security group

resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  description = "Allow utc-app inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.v1.id

  tags = {
    Name = "allow utc-app1"
  }
}

#ssh rule (22 for SSH, allow only your IP)
resource "aws_security_group_rule" "ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["104.28.116.6/32"] #replace with your actual ip address
    security_group_id = aws_security_group.webserver-sg.id
    description = "Allow ssh from my IP"
}

#Apache rule (80 for HTTP, open to the world)
resource "aws_security_group_rule" "http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver-sg.id
  description = "Allow http from anywhere"
}

#Port 8080 rule, open everywhere 
resource "aws_security_group_rule" "port_8080" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver-sg.id
  description = "allow 8080 from anywhere"
}