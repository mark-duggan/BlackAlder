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

resource "aws_instance" "bastion" {
  ami                    = nonsensitive(data.aws_ssm_parameter.linux-ami.value)
  instance_type          = var.ec2_instance
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  key_name               = aws_key_pair.terraform_key.key_name
  tags                   = merge(local.common_tags, {Name = "bastion"})

  user_data = <<EOF
#! /bin/bash
echo Starting User Data $(date +"%Y-%m-%dT%H:%M:%S%z")
sudo apt update -y
sudo touch /home/ubuntu/.hushlogin
sudo echo "Userdata Completed" > /root/tf.log
EOF

}

resource "aws_instance" "ubu1" {
  ami                    = nonsensitive(data.aws_ssm_parameter.linux-ami.value)
  instance_type          = var.ec2_instance
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.linux-internal-sg.id]
  key_name               = aws_key_pair.terraform_key.key_name
  tags                   = merge(local.common_tags, {Name = "ubu1"})

  user_data = <<EOF
#! /bin/bash
echo Starting User Data $(date +"%Y-%m-%dT%H:%M:%S%z")
sudo apt update -y
sudo touch /home/ubuntu/.hushlogin
sudo echo "Userdata Completed" > /root/tf.log
EOF

}

resource "aws_instance" "win1" {
  ami                    = nonsensitive(data.aws_ssm_parameter.windows-ami.value)
  instance_type          = var.win_ec2_instance
  subnet_id              = aws_subnet.subnet3.id
  vpc_security_group_ids = [aws_security_group.windows-sg.id]
  key_name               = aws_key_pair.terraform_key.key_name
  tags                   = merge(local.common_tags, {Name = "win1"})

  user_data = <<EOF
echo Starting User Data $(date +"%Y-%m-%dT%H:%M:%S%z")
EOF

}

resource "aws_ebs_volume" "win_data_1" {
  availability_zone = "us-east-1c"
  size = 5
}

resource "aws_ebs_volume" "win_data_2" {
  availability_zone = "us-east-1c"
  size = 7
}

resource "aws_ebs_volume" "win_data_3" {
  availability_zone = "us-east-1c"
  size = 10
}

resource "aws_volume_attachment" "win_data_1_att" {
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.win_data_1.id
  instance_id = aws_instance.win1.id
}

resource "aws_volume_attachment" "win_data_2_att" {
  device_name = "/dev/sdc"
  volume_id = aws_ebs_volume.win_data_2.id
  instance_id = aws_instance.win1.id
}

resource "aws_volume_attachment" "win_data_3_att" {
  device_name = "/dev/sdd"
  volume_id = aws_ebs_volume.win_data_3.id
  instance_id = aws_instance.win1.id
}
