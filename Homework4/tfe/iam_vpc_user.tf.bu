resource "aws_iam_user" "network" {
  name = "network-tf-user"
  path = "/terraform/"
}

resource "aws_iam_user_policy_attachment" "network" {
  user       = aws_iam_user.network.name
  policy_arn = var.aws_vpc_allaccess_policy
}

resource "aws_iam_access_key" "network" {
  user    = aws_iam_user.network.name
  pgp_key = format("keybase:%s", "network-tf-user")
}

output "secret_key" {
  value     = aws_iam_access_key.network.secret
  sensitive = true
}

output "access_key" {
  value = aws_iam_access_key.network.id
}
