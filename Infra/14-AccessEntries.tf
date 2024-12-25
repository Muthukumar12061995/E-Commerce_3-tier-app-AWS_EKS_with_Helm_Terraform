resource "aws_iam_user" "devops_user" {
  name = "DevOps"
}

resource "aws_iam_role" "devops-admin-role" {
  name = "devops-admin-role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "AWS" : "*"
          }
          # "Condition" : {
          #   "StringEquals" : {
          #     "aws:PrincipalTag/Group" : "DevOps-admin"
          #   }
          # }
        }
      ]
    }
  )
}

# resource "aws_eks_access_entry" "devOps" {
#   cluster_name      = aws_eks_cluster.eks.name
#   principal_arn     = aws_iam_user.devops_user.arn
#   kubernetes_groups = ["devops-admin"]
#   type              = "STANDARD"
# }


resource "aws_eks_access_entry" "devOps_role" {
  cluster_name      = aws_eks_cluster.eks.name
  principal_arn     = aws_iam_role.devops-admin-role.arn
  kubernetes_groups = ["devops-admin"]
  type              = "STANDARD"
}

