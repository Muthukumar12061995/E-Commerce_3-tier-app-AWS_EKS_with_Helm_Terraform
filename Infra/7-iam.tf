
###########  EKS Cluster Role and Policy ##########

resource "aws_iam_role" "eks_cluster_role" {
  name = "${local.cluster_name}-eks-cluster-role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "eks.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

##########  EKS Worker Node Policy  ##########

resource "aws_iam_role" "worker_node_role" {
  name = "${local.cluster_name}-eks-worker-node-role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17"
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}

# This policy now includes AssumeRoleForPodIdentity for the Pod Identity Agent

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.worker_node_role.name
}

# To manage secondary IP's for the Pods

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker_node_role.name
}

# To provide read only access to ECR

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_node_role.name
}



