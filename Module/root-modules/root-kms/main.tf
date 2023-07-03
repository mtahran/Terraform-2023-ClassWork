module "s3-kms-key" {
  source                  = "../../child-modules/kms"
  description             = "kms key for s3 bucket"
  deletion_window_in_days = 7
  is_enabled              = true
  enable_key_rotation     = true

}