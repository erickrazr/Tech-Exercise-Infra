
resource "aws_security_group" "MongoCentosSG" {
  name        = "MongoCentosSG"
  description = "MongoCentosSG"
  vpc_id      = aws_vpc.main.id
  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance

resource "aws_instance" "mongodb_instance" {
  iam_instance_profile = aws_iam_instance_profile.ec2_full_profile.name
  instance_type          = "t2.medium"
  ami                    = "ami-09a7b0709b6a96407"
  key_name               = "eferreira-kp-useast1"

  network_interface {
     network_interface_id = "${aws_network_interface.mongoInterface.id}"
     device_index = 0

  }


  root_block_device {
    volume_size = 20
  }
  tags = {
    Name = "eferreira-kp-useast1"
  }
}

resource "aws_network_interface" "mongoInterface" {
  subnet_id = aws_subnet.public-us-east-1a.id
  private_ips = ["10.0.74.223"]
  security_groups = [aws_security_group.MongoCentosSG.id]
  
  tags = {
    Name = "primary_network_interface"
  }
}

data "aws_iam_role" "ec2_full_role" {
  name = "EC2-AdminAccess"
}

resource "aws_iam_instance_profile" "ec2_full_profile" {
  role = data.aws_iam_role.ec2_full_role.name
}
