# Policy allows the EBS CSI driver pod to call AWS services to provision volume on your behalf.

# Attach the EBS Policy to the EKS Worker Node Role: 
resource "aws_iam_role_policy_attachment" "amazon_ebs_csi_policy" {
  role       = aws_iam_role.worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

# Deploying ebs csi driver using terraform
resource "aws_eks_addon" "ebs_csi_driver" {
  addon_name    = "aws-ebs-csi-driver"
  cluster_name  = aws_eks_cluster.eks.name
  addon_version = "v1.36.0-eksbuild.1"
}