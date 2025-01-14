provider "aws" {
  region = "us-east-1"  # specify your preferred AWS region
}

resource "aws_instance" "master" {
  ami           = "ami-0c55b159cbfafe1f0"  # replace with an appropriate AMI ID
  instance_type = "t2.micro"
  tags = {
    Name = "master-node"
  }
}

resource "aws_instance" "worker" {
  count         = 2
  ami           = "ami-0c55b159cbfafe1f0"  # same or another appropriate AMI ID
  instance_type = "t2.micro"
  tags = {
    Name = "worker-node-${count.index + 1}"
  }
}

output "master_ip" {
  value = aws_instance.master.public_ip
}

output "worker_ips" {
  value = [for instance in aws_instance.worker : instance.public_ip]
}
