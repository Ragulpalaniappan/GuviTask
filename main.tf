provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}

resource "aws_instance" "ec2_us_east" {
  provider               = aws.us_east_1
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  key_name               = "us-east-1"
  associate_public_ip_address = true

  user_data = file("./install_nginx.sh")  # Pointing to the script

  tags = {
    Name = "Nginx-Server-East"
  }
}

resource "aws_instance" "ec2_us_west" {
  provider               = aws.us_west_2
  ami                    = "ami-07d9cf938edb0739b" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  key_name               = "us-west-2" # Replace with your key pair name
  associate_public_ip_address = true

  user_data = file("./install_nginx.sh")  # Pointing to the script

  tags = {
    Name = "Nginx-Server-West"
  }
}

output "us_east_instance_ip" {
  value = aws_instance.ec2_us_east.public_ip
}

output "us_west_instance_ip" {
  value = aws_instance.ec2_us_west.public_ip
}

