resource "aws_iam_role" "ec2_web_role" {
  name = "ec2_web_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "ec2_web_role"
  }
}

resource "aws_iam_instance_profile" "ec2_web_profile" {
  name = "ec2_web_profile"
  role = aws_iam_role.ec2_web_role.name
}

resource "aws_iam_role_policy" "ec2_web_policy" {
  name = "ec2_web_policy"
  role = aws_iam_role.ec2_web_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
        ]
        Effect   = "Allow"
        Resource = format("arn:aws:s3:::%s/*", var.s3_logs_bucket)
      },
    ]
  })
}
