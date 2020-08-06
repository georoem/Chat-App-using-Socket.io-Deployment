variable "project" {
  default = "acklen-avenue-challenge"
}

variable "environment" {
  default = "test"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "key_name" {
  default = "deployer_key_name"
}

variable "deployer_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAlN/+AAku0cUbT8ACLLYv0fBrQixtZPTxlfTnCP8E87RhDcGn+LU/g0UxdSv6dLb8hKCDRPKDcNmxI7/YlDGIT9Jy9ggTTE2q3lJBn0cf5upYf5QfmxZPrtgV1REm76oJ87tRqKIaM9drPOEORfm5npWQ1bA/wjo/gpqpFFcMhkEPzHTNp72zlp9Eg2xjymfirMhWhAXif5H5ZoQ6mvXmMFZ4dVAhX5A6HWrvzAJ8wqsxy563p6UGKQn6lHVTyqLe4gYBwfAfGppiVoKNejZ5bJx33018BKQdL04NB+232o2lCcIkUgSlPPlE7eQGXBuj7Q70V4IuoWquQgofegtP1w=="
}