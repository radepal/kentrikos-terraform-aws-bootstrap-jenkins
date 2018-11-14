output "jenkins_private_ip" {
  description = "The private IP address assigned to the instance"
  value       = "${aws_instance.jenkins_master_node.private_ip}"
}

output "jenkins_username" {
  description = "The username assigned to the instance."
  value       = "ec2-user"
}

output "ssh_private_key" {
  description = "The SSH private key."
  value       = "${tls_private_key.jenkins_master_node_key.private_key_pem}"
  sensitive   = true
}

output "ssh_connection" {
  description = "The SSH connection string for remote management."
  value       = "${format("ssh -i '~/.ssh/%s.pem' %s@%s", aws_key_pair.jenkins_master_node_key.key_name, "ec2-user", aws_instance.jenkins_master_node.private_ip)}"
}
