

resource "aws_ecs_cluster" "cluster" {
  name                  = "ecs_cluster"

tags = {
    Environment = var.environment_name
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "ecs_task_definition"
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]

  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory

  container_definitions    = <<DEFINITION
[
  {
    "name": "cloudrockproject",
    "image": "nginx:latest",
    "cpu": 1024,
    "memory": 2048,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "essential": true
  }
]
DEFINITION

tags = {
    Environment = var.environment_name
  }
}

resource "aws_ecs_service" "backend" {
  name            = "ecs_service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 4
  launch_type     = "FARGATE"

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.frontend.arn
    container_name   = "cloudrockproject"
    container_port   = 80
  }

tags = {
    Environment = var.environment_name
  }
}









