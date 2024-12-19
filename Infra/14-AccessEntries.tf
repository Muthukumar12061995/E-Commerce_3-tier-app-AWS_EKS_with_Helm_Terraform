resource "aws_eks_access_entry" "devOps" {
  cluster_name = aws_eks_cluster.eks.name
  principal_arn = "arn:aws:iam::992382557570:group/DevOps"
  kubernetes_groups = [ "system:masters" ]
  type = "STANDARD"
}

