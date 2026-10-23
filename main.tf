provider "aws" {
  region  = "ap-south-1"
  profile = "terraform-learner"
}

resource "aws_s3_bucket" "website" {
  bucket_prefix = "tf-website-learner-"

  tags = {
    Name        = "terraform-s3-website"
    Environment = "learning"
    ManagedBy   = "Terraform"
  }
}