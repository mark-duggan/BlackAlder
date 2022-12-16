## DATA ##

data "aws_ssm_parameter" "linux-ami" {
  name = "/aws/service/canonical/ubuntu/server/focal/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

data "aws_ssm_parameter" "windows-ami" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

# INSTANCES #

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = local.public_key
}

resource "aws_instance" "ubu1" {
  ami                    = nonsensitive(data.aws_ssm_parameter.linux-ami.value)
  instance_type          = var.ec2_instance
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.linux-sg.id]
  key_name               = aws_key_pair.terraform_key.key_name
  tags                   = merge(local.common_tags, {Name = "ubu1"})

  user_data = <<EOF
#! /bin/bash
echo Starting User Data $(date +"%Y-%m-%dT%H:%M:%S%z")
sudo apt update -y
sudo echo "Userdata Completed" > /root/tf.log
EOF

}

resource "aws_instance" "win1" {
  ami                    = nonsensitive(data.aws_ssm_parameter.windows-ami.value)
  instance_type          = var.ec2_instance
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.windows-sg.id]
  key_name               = aws_key_pair.terraform_key.key_name
  tags                   = merge(local.common_tags, {Name = "win1"})

  user_data = <<EOF
echo Starting User Data $(date +"%Y-%m-%dT%H:%M:%S%z")
EOF

}