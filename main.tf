# Get latest ECS AMI

data "aws_ami" "ecs" {
  most_recent = var.ami_latest

  dynamic "filter" {
    for_each = var.ami_filter
    content {
      name   = filter.value["name"]
      values = list(filter.value["values"])
    }
  }
  owners = var.ami_owners
}

# Optionally create Keypair

resource "aws_key_pair" "key_pair" {
  count      = var.key_public_material != "" ? 1 : 0
  key_name   = var.key_name != "" ? var.key_name : var.name
  public_key = var.key_public_material
}

locals {
  image_id      = var.image_id == "" ? data.aws_ami.ecs.id : var.image_id
  key_pair_name = var.key_public_material != "" ? join(",", aws_key_pair.key_pair.*.key_name) : var.key_name
}

resource "aws_iam_role" "instance_role" {
  name               = format("%s-%s", var.name, "instance")
  assume_role_policy = file("${path.module}/instance_role_assume_role_policy.json")
}

resource "aws_iam_role_policy" "instance_role_policy" {
  name   = format("%s-%s", var.name, "instance")
  role   = aws_iam_role.instance_role.id
  policy = file("${path.module}/instance_role_policy.json")
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = format("%s-%s", var.name, "instance-profile")
  role = aws_iam_role.instance_role.name
}

# Create Launch Config
resource "aws_launch_configuration" "lc" {
  name_prefix                 = "${var.name}-lc-"
  image_id                    = local.image_id
  instance_type               = var.instance_type
  key_name                    = local.key_pair_name
  security_groups             = [var.security_group_id]
  user_data                   = var.user_data
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name
  root_block_device {
    encrypted = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = var.name
  launch_configuration = aws_launch_configuration.lc.name
  min_size             = var.min_size
  max_size             = var.max_size
  vpc_zone_identifier  = var.subnet_ids
  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    ignore_changes = [target_group_arns]
  }
}
