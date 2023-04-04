resource "aws_s3_bucket" "bankyS3"{
    bucket = "learning-aws-s3-001"
    acl = "private"
}

resource "aws_s3_bucket_website_configuration" "bankys3" {
    bucket = aws_s3_bucket.bankys3.bucket
    index_document {
        suffix = "index.html"
    }
}

resource "vpc" "staging" {
    cidr_blocks = "10.0.0.0/16"
}

resource "vpc" "test" {
    cidr_blocks = "10.1.0.0/24"
}

resource "vpc" "prod" {
    cidr_blocks = "10.2.0.0/16"
}

resource "aws_security_group" "allow_tls" {
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["1.2.3.4/32"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" #anyprotocol on any port
    }
}
#OR
resource "aws_security_group" "allow_tls" {}

resource aws_security_group_rule" "https_inbound" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["1.2.3.4/32]
    security_group_id = aws_security_group.allow_tls.id
}

resource aws_security_group_rule" "https_outboud" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.allow_tls.id
}

resource "aws_instance" "blog" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.nano"
}

resource "aws_eip" "blog" {                              #eip elastic IP in aws meaning static IP    
    instance = aws_instance.blog.index_id
    vpc = true
}

#resource "aws_instance" "web" {
#   count = 2 #2 is a meta argument meaning terraform will create two instances meta argument can also be used to explicitly define a dependency relationship between two resources

#   ami = "abc123"
#   instance_type = "t2.micro"

#   network_interface {
    #.....
    }

    lifecycle {
        create_before_destroy = true #this is an example of block format meta argument This should always go at the end of the resource definition
    }
#}  
