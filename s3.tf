resource "aws_s3_bucket" "remote_state" {
  bucket = var.name
  acl    = "private"

  versioning {
    enabled    = true
  }
}

data "aws_iam_policy_document" "remote_state_always_enc" {
  statement {
    sid       = "DenyIncorrectEncryptionHeader"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }
  }

  statement {
    sid       = "DenyUnEncryptedObjectUploads"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }
}

resource "aws_s3_bucket_policy" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  policy = data.aws_iam_policy_document.remote_state_always_enc.json
}

