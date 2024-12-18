resource "aws_eks_node_group" "eks_worker_node" {
  cluster_name  = aws_eks_cluster.eks.name
  node_role_arn = aws_iam_role.eks_worker_node_role.arn
  # Private worker nodes
  # subnet_ids    = [aws_subnet.private_subnet_zone1.id, aws_subnet.private_subnet_zone2.id]

  # Public worker nodes
  subnet_ids = [aws_subnet.public_subnet_zone1.id, aws_subnet.public_subnet_zone2.id]

  scaling_config {
    min_size     = 1
    max_size     = 1
    desired_size = 1
  }

  remote_access {
    ec2_ssh_key = aws_key_pair.ec2_ssh_key.id
    # Sourcer SG allowed to have ssh access to workload
    # source_security_group_ids = [aws_security_group.eks_workerNode_sg.id]
  }

  tags = {
    Name = "${local.cluster-name}-worker-node"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.

  depends_on = [
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.ec2_ecr_read_only
  ]
}