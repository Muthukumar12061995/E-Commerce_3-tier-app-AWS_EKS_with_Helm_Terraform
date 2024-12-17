resource "aws_eks_cluster" "eks" {
  name = local.cluster-name

  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    security_group_ids = [ aws_security_group.eks_cluster_sg.id,aws_security_group.eks_workerNode_sg.id ]
    endpoint_private_access = true
    endpoint_public_access = true
    subnet_ids = [ aws_subnet.private_subnet_zone1.id,aws_subnet.private_subnet_zone2.id ]
  }

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true 
  }
  
  depends_on = [ aws_iam_role_policy_attachment.eks_cluster_policy ]

  tags = {
    Name = "${local.cluster-name}-eks-cluster"
  }
}