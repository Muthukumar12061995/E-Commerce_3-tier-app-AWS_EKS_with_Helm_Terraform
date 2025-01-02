# IAM role for ALB Ingress Controller using OIDC
# Create IAM Role for ALB Ingress Controller using the OIDC provider

resource "aws_iam_role" "alb_ingress_role" {
  name = "alb_ingress_controller_role"
  assume_role_policy = jsonencode(
    {
        "Version" : "2012-10-17",
        "Statement" : [
            {
                "Effect" : "Allow",
                "Action" : "sts:AssumeRoleWithWebIdentity",
                "Principal" : {
                    "Federated" : aws_eks_cluster.eks.arn
                },
                "Condition" : { 
                    "StringEqual" : {
                        "${replce(aws_eks_cluster.eks.identity[0].oidc[0].issuer,"https://","")}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
                    }
                }
            }


        ]
    }
  )
}