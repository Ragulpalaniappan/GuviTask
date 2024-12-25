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
  ami                   = "ami-0c02fb55956c7d316"
  instance_type         = "t2.micro"
  key_name              = "New"
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./jenkins_demo")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "Nginx-Server-East"
  }
}

resource "aws_instance" "ec2_us_west" {
  provider               = aws.us_west_2
  ami                   = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (Change as per your region)
  instance_type         = "t2.micro"
  key_name              = "New" # Replace with your key pair name
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./jenkins_demo")
      host        = self.public_ip
    }
  }

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
