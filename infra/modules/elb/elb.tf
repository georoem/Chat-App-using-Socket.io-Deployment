data "aws_elb_service_account" "this" {}

resource "aws_s3_bucket" "logs" {
  bucket = format("elb-%s-%s-%s", var.project, var.environment, "s3")
  acl    = "log-delivery-write"
  policy        = data.aws_iam_policy_document.logs.json
  force_destroy = true
}

data "aws_iam_policy_document" "logs" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.this.arn]
    }

    resources = [
      "arn:aws:s3:::elb-${var.project}-${var.environment}-s3/*",
    ]
  }
}

resource "aws_elb" "load_balancer" {
  name               = format("%s-%s-%s", var.project, var.environment, "elb")
  security_groups = var.sg_ids
  
  listener {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  access_logs {
    bucket        = format("elb-%s-%s-%s", var.project, var.environment, "s3")
    bucket_prefix = "logs"
    interval      = 60
  }

  instances                   = var.instance_ids
  subnets = var.subnet_ids
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = format("%s-%s-%s", var.project, var.environment, "elb")
  }
}