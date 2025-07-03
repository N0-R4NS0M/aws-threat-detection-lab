resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_guardduty_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_ec2_policy" {
  name = "lambda_ec2_access"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:CreateTags",
          "ec2:RevokeSecurityGroupIngress"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/isolate_instance.py"
  output_path = "${path.module}/../lambda/isolate_instance.zip"
}

resource "aws_lambda_function" "isolate_instance" {
  function_name = "IsolateThreatInstance"
  handler       = "isolate_instance.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout       = 30
}

resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  name        = "guardduty-threat-detected"
  description = "Triggers when GuardDuty detects a threat"
  event_pattern = jsonencode({
    source = ["aws.guardduty"],
    detail = {
      type = [{ "prefix": "Recon:" }]  # Customize this as needed
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.guardduty_findings.name
  target_id = "IsolateInstanceFunction"
  arn       = aws_lambda_function.isolate_instance.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.isolate_instance.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.guardduty_findings.arn
}
