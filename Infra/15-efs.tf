resource "aws_eks_addon" "efs_csi_driver" {
  addon_name = "aws-efs-csi-driver"
  cluster_name = aws_eks_cluster.eks.name
}

resource "aws_security_group" "efs_sg" {
  name = "efs_sg"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = "2049"
    to_port = "2049"
    protocol = "TCP"
    cidr_blocks = [ aws_vpc.vpc.cidr_block ]
  }

  tags = {
    Name = "${local.cluster-name}-efs-sg"
  }
}

resource "aws_efs_file_system" "efs" {
  encrypted = true 
  # Create a file system with a specific performance mode (e.g., general purpose or max I/O)
  performance_mode = "generalPurpose"  # or "maxIO" depending on your needs

  tags = {
    Name = "${local.cluster-name}-efs"
  }

}

# resource "aws_efs_mount_target" "efs_mount_target1" {
#   file_system_id = aws_efs_file_system.efs.id
#   subnet_id = aws_subnet.private_subnet_zone1.id

#   security_groups = [ aws_security_group.efs_sg.id ]
# }

# resource "aws_efs_mount_target" "efs_mount_target2" {
#   file_system_id = aws_efs_file_system.efs.id
#   subnet_id = aws_subnet.private_subnet_zone2.id

#   security_groups = [ aws_security_group.efs_sg.id ]
# }

resource "aws_efs_access_point" "nginx_access" {
  file_system_id = aws_efs_file_system.efs.id
  posix_user {
    uid = "1001"
    gid = "1001"
  }

  root_directory {
    path = "/nginx-data"
  }
}

resource "kubernetes_storage_class" "efs_sc" {
  metadata {
    name = "efs-sc"
  }
  storage_provisioner = "efs.csi.aws.com"
  reclaim_policy = "Retain"
  volume_binding_mode = "Immediate"
  
  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId = aws_efs_file_system.efs.id
    accessPointId = aws_efs_access_point.nginx_access.id
  }

}

resource "kubernetes_persistent_volume_claim" "efs_pvc" {
  metadata {
    name = "efs-pvc"
  }

  spec {
    storage_class_name = "efs-sc"
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}