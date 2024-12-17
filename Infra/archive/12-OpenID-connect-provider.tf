# Data source to retrieve the certificate of the EKS API server endpoint
data "tls_certificate" "eks_tls" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer

  depends_on = [aws_eks_cluster.eks]
}

# Create an IAM OpenID Connect provider for EKS OIDC authentication
# add the cluster OIDC issuer to the IAM service identity providers.
resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_tls.certificates[0].sha1_fingerprint]

  depends_on = [aws_eks_cluster.eks]
}