#setup variable for terraform
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
<<<<<<< HEAD
  default     = "ami-0c55b159cbfafe1f0" # Example AMI ID, replace with a valid one for your region
=======
  default     = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one for your region
>>>>>>> e482348 (Code Update)
}

variable "key_name" {
  description = "The name of the SSH key pair to use for accessing the EC2 instance"
<<<<<<< HEAD
  type        = string
  default     = "my-key-pair" # Replace with your actual key pair name
=======
    type        = string
    default = "Linux1"
>>>>>>> e482348 (Code Update)
}
