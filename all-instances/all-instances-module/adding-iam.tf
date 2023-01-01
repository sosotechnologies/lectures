#Create an IAM Policy
resource "aws_iam_policy" "soso-s3-policy" {
  name        = "S3-Bucket-Access-Policy"
  description = "Provides permission to access S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = [

 "arn:aws:s3:::soso-bucket1/*" ]
      },
      {
        Action = [
          "eks:ListUpdates",
          "eks:ListTagsForResource",
          "eks:ListNodegroups",
          "eks:ListIdentityProviderConfigs",
          "eks:ListFargateProfiles",
          "eks:ListAddons",
          "eks:DescribeCluster"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:eks:us-east-1:1234567890:cluster/*", ]   # aws eks describe-cluster --name []  # Describe the cluster and edit in here
      },
    ]
  })
}

#Create an IAM Role
resource "aws_iam_role" "soso-instance-role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "RoleForEC2"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "soso-attach" {
  name       = "soso-attachment"
  roles      = [aws_iam_role.soso-instance-role.name]
  policy_arn = aws_iam_policy.soso-s3-policy.arn
}

resource "aws_iam_instance_profile" "soso-profile" {
  name = "soso_profile_role"
  role = aws_iam_role.soso-instance-role.name
}