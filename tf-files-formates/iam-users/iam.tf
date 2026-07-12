resource "aws_iam_user" "iam_users" {
  count = length(var.iam_users)
  name = var.iam_users[count.index]

  tags = {
    Name = "${var.iam_users[count.index]}"
  }
}

variable "iam_users" {
  type    = list(string)
  default = ["user1", "user2", "user3","user4","user5"]
}
