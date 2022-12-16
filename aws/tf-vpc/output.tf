output "ubuntu_public_ip" {
  value = aws_instance.ubu1.public_ip
}

output "ubuntu_private_ip" {
  value = aws_instance.ubu1.private_ip
}

output "windows_public_ip" {
  value = aws_instance.win1.public_ip
}

output "windows_private_ip" {
  value = aws_instance.win1.private_ip
}