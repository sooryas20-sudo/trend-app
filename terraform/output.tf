output "jenkins_url" {
  value = "http://${aws_instance.web.public_ip}:8080"
}

output "eks_cluster_name" {
  value = aws_eks_cluster.trend_cluster.name
}
