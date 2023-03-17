
resource "aws_iam_role" "s3_access" {
  name = "S3_AccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "s3_access_policy" {
  name = "VOIS_S3_Access_Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  policy_arn = aws_iam_policy.s3_access_policy.arn
  role       = aws_iam_role.s3_access.name
}


resource "aws_iam_instance_profile" "instance-profile" {
  name = "instance-profile"
  role = aws_iam_role.s3_access.name
}


resource "aws_instance" "my_vm" {
  ami                         = "ami-0055e70f580e9ae80" //Amazonn Linux 2
  instance_type               = "t2.micro"
  key_name                    = "VOIS_Task"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance-profile.name

  tags = {
	Name = "Logger_Task_EC2",
	VOIS_Task_EC2 = "VOIS_Task_EC2"
  }
}



resource "aws_s3_bucket" "my_s3" {
  bucket = "vois-logging-bucket"
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.my_s3.id
  acl    = "private"
}


