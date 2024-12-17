resource "aws_key_pair" "ec2_ssh_key" {
  public_key = file("~/.ssh/ec2.pub")
  key_name   = "ec2-ssh"
}


resource "aws_security_group" "eks_workerNode_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "inbound - allow worker Kubelets and pods to receive communication from the cluster control plane"
    from_port = "1024"
    to_port = "65535"
    protocol = "tcp"
    security_groups = [ aws_security_group.eks_cluster_sg.id ]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${local.cluster-name}-woker-node-sg"
  }
}

# Inorder to avoid cycle reference

resource "aws_security_group_rule" "eks_workerNode_ingress_sg" {

  description = ""
  type = "ingress"
  from_port = "0"
  to_port = "65535"
  protocol = "-1"
  security_group_id = aws_security_group.eks_workerNode_sg.id
  source_security_group_id = aws_security_group.eks_workerNode_sg.id  
}

resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "inbound - allow worker nodes to communicate with cluster api server"
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    security_groups = [ aws_security_group.eks_workerNode_sg.id ]
  }

  egress {
    description = "outbound - allow cluster api server to communicate with worker node"
    from_port = "1024"
    to_port = "65535"
    protocol ="tcp"
    security_groups = [ aws_security_group.eks_workerNode_sg.id ]
  }
  
  tags = {
    Name = "${local.cluster-name}-cluster-sg"
  }
  
}