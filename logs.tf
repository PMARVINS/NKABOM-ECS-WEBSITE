# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "myapp_log_group" {
  name              = "ecs-cloudwatch"
  retention_in_days = 30

  tags = {
    Environment = var.environment_name
  }
}

resource "aws_cloudwatch_log_stream" "myapp_log_stream" {
  name           = "my-log-stream"
  log_group_name = aws_cloudwatch_log_group.myapp_log_group.name

tags = {
    Environment = var.environment_name
  }
}