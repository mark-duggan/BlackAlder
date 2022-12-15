resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }
  public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1eRGvSudPLbjF1uyHGGaths3OTo75mTM/NCbenM3RZQYg6n7EMCuRCGWFzusCqXDWdITN+43vndt9XeBP0Dfl10xauU6UmZ4DHC4NQOGLjEdGYsEmeriLKY456sX234uvHFKE7GZvOUfy0V4Ciu606ZH+J7rb8SrwjaX/kJlE+Pn6hQEu5i9ZcmOCrlgp4TUCsPVRlc6NiJnhdSGroRQRik0EM8X6nXFaWrITu/MzkMl4mj4gjRgsk2vL1aoxrJklOpZ4pwcUqLzPPGbQaV8lMIU6LWziEBUwqsG0mGostHpHz5+kTVqpYpWeIPmjKz+21q2CJbgw9d8WAfytgZOt"
}
