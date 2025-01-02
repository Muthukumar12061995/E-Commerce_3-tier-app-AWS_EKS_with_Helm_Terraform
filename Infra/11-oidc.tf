data "tls_certificate" "ca_thumprint" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer

  thumbprint_list = [data.tls_certificate.ca_thumprint.certificates[0].sha1_fingerprint]

  client_id_list = ["sts.amazonaws.com"]
}