terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.69.0"
    }
  }
}
provider "aws" {
  region = "eu-central-1"
}
###########################################################
#creating IAM role with base policy
resource "aws_iam_role" "role" {
  name               = var.iam_role_name
  assume_role_policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
	 "Effect":"Allow",
	 "Principal":{
	    "Service":"credentials.iot.amazonaws.com"
    },
	 "Action":"sts:AssumeRole"
 }
   ]
}   
EOF
}
#creating policy for KVS streaming
resource "aws_iam_policy" "policy" {
  name        = var.iam_policy_name
  description = "iam policy for creating stream"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kinesisvideo:DescribeStream",
                "kinesisvideo:PutMedia",
                "kinesisvideo:TagStream",
                "kinesisvideo:GetDataEndpoint",
                "kinesisvideo:CreateStream"
            ],
            "Resource": "arn:aws:kinesisvideo:*:*:stream/$${credentials-iot:ThingName}/*"
        }
    ]
}
EOF
}
#attaching policy to iam role
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
#creating role alias
resource "aws_iot_role_alias" "alias" {
  alias               = var.iot_role_alias_name
  role_arn            = aws_iam_role.role.arn
  credential_duration = var.role_alias_duration
  depends_on = [
    aws_iam_role.role
  ]
}
#creating policy for role alias to be attached to cert
resource "aws_iot_policy" "pubsub" {
  name = var.camera_iot_policy
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iot:Connect"
        ],
        "Resource" : "${aws_iot_role_alias.alias.arn}"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iot:AssumeRoleWithCertificate"
        ],
        "Resource" : "${aws_iot_role_alias.alias.arn}"
      }
    ]
  })
}
/*
#creating IOT Cert
resource "aws_iot_certificate" "cert" {
  active = true
}
#attach policy to cert
resource "aws_iot_policy_attachment" "att" {
  policy = aws_iot_policy.pubsub.name
  target = aws_iot_certificate.cert.arn
}
#IOT Thing
resource "aws_iot_thing" "drone" {
  name = var.iot_thing_name
}
#attaching thing to cert
resource "aws_iot_thing_principal_attachment" "att" {
  principal = aws_iot_certificate.cert.arn
  thing     = aws_iot_thing.drone.name
}
#create KVS
resource "aws_kinesis_video_stream" "default" {
  name                    = aws_iot_thing.drone.name
  data_retention_in_hours = 1
  tags = {
    Name = aws_iot_thing.drone.name
  }
}
*/
