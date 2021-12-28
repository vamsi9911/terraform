provider "aws" {
    region     = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "aws_iam_role" "EC2SSMRole" {
  name = "EC2SSMRole"
  assume_role_policy = "${file("EC2SSMRole.json")}"
  tags = {
    name = "EC2SSMRole"
  }
}

resource "aws_iam_role_policy" "SecretsManagerReadWrite" {
  name = "SecretsManagerReadWrite"
  role = "${aws_iam_role.EC2SSMRole.id}"

  policy = "${file("SecretsManagerReadWrite.json")}"
}

resource "aws_iam_role_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
  role = "${aws_iam_role.EC2SSMRole.id}"

  policy = "${file("AmazonSSMManagedInstanceCore.json")}"
}