terraform {
  backend "s3" {
    bucket = "bd.tf.backends"
    key = "AnsibleRef-TFState"
    region = "us-west-1"
    profile = "my_aws"
  }
}