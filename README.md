tf_mod_aws_remotestate
==

A Terraform module for creating an initial S3 bucket for remote state storage
and a DynamoDB table for remote state locking.

```
module "remote_state" {
  source = "git::https://git.steamhaus.co.uk/steamhaus/tf_mod_aws_remotestate"

  name  = "my-awesome-remote-state"
}
```

Notes:
- The name variable names both the S3 bucket and the DynamoDB table and therefore
needs to be globally unique.
- The S3 bucket policy only allows SSE object uploads so ensure Terraform is
configured with the encryption setting on the S3 backend.
