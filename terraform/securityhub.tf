resource "aws_securityhub_account" "main" {}

resource "aws_securityhub_standards_subscription" "cis_aws_foundations" {
  standards_arn = "arn:aws:securityhub:::standards/cis-aws-foundations-benchmark/v/1.2.0"
  depends_on = [aws_securityhub_account.main]
}
