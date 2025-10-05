terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = "us-east-1"
}

# Generate a random suffix to make bucket names globally unique
resource "random_id" "suffix" {
  byte_length = 4
}

# ---------------------------
# Logging bucket (for access logs)
# ---------------------------
resource "aws_s3_bucket" "log_bucket" {
  # checkov:skip=CKV_AWS_18 Reason: Logging buckets should not log themselves
  bucket = "${var.bucket_name}-${random_id.suffix.hex}-logs"

  tags = {
    Name        = "${var.bucket_name}-logs"
    Environment = var.environment
  }
}

# Enforce bucket ownership and disable ACLs
resource "aws_s3_bucket_ownership_controls" "log_bucket_ownership" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# 👇 Only if you need ACLs for log delivery
#resource "aws_s3_bucket_acl" "log_bucket_acl" {
#  depends_on = [aws_s3_bucket_ownership_controls.log_bucket_ownership]
#  bucket     = aws_s3_bucket.log_bucket.id
#  acl        = "log-delivery-write"
#}

# Enable versioning for the log bucket
resource "aws_s3_bucket_versioning" "log_bucket_versioning" {
  bucket = aws_s3_bucket.log_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access for the logging bucket
resource "aws_s3_bucket_public_access_block" "log_block_public" {
  bucket                  = aws_s3_bucket.log_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ---------------------------
# Main secure bucket
# ---------------------------
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "${var.bucket_name}-${random_id.suffix.hex}"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# Enable versioning on secure bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.secure_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption (AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access for secure bucket
resource "aws_s3_bucket_public_access_block" "secure_block_public" {
  bucket                  = aws_s3_bucket.secure_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
