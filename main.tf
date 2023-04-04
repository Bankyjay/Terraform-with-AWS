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