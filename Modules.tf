#this should be in the main file there should be folder with the name modules
module "web_server" {
    source = "./modules/servers"
    web_ami = "ami-12345"
    Server_name = "prod-web"
}

variable "web_ami" {
    type = string
    default = "ami-abc123"
}

variable "server_name" {
    type = string
}

output "instance_public_ip" {
    value = aws_instance.web_app.public_ip
}
output "app_bucket" {
    value = aws_s3_bucket.web_app.bucket
}