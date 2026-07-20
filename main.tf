terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. A basic IAM role for the Lambda
resource "aws_iam_role" "lambda_role" {
  name = "demo_deprecated_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# 2. A dynamic dummy zip file so 'terraform plan' succeeds
data "archive_file" "dummy_code" {
  type        = "zip"
  output_path = "${path.module}/dummy_lambda.zip"
  source {
    content  = "def lambda_handler(event, context): pass"
    filename = "index.py"
  }
}

# 3. The vulnerable resource that triggers your Wiz Policy
resource "aws_lambda_function" "deprecated_function" {
  function_name    = "demo_deprecated_runtime_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.lambda_handler"
  
  # THE TRIGGER: Python 3.6 is heavily deprecated
  runtime          = "python3.6" 
  
  filename         = data.archive_file.dummy_code.output_path
  source_code_hash = data.archive_file.dummy_code.output_base64sha256
}