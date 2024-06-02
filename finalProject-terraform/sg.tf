# Open access to the LB from the world
resource "aws_security_group" "web_server_lb" {
  name        = "web-server-lb-sg"
  description = "Allow HTTP access from the world"
  vpc_id      = module.vpc.vpc_id
  
  # Inbound traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # All protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = "web-server-lb-sg"
  }
}

# Open access to the web servers from the LB
resource "aws_security_group" "internal" {
  name        = "web-server-internal-sg"
  description = "Allow traffic between LB and servers"
  vpc_id      = module.vpc.vpc_id

  # Inbound traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    self        = true
  }

  # Outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # All protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = "web-server-internal-sg"
  }
}

# Open access to the web servers to the world
resource "aws_security_group" "web_servers" {
  name        = "web-servers-sg"
  description = "Allow SSH access from the world"
  vpc_id      = module.vpc.vpc_id

  # Inbound traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  # Outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # All protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-servers-sg"
  }
}
