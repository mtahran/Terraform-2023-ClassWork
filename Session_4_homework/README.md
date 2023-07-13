You can create EC2 and S3 resources with S3 backend with these configuration files.
 
What we have in these folders:
   FOLDER-1 EC2-SG-IAM
1- EC2 Instance:

--instance_type: t2.micro

--key_name: your-ssh-key

--ami: data source Ubuntu image

--user_data: install Terraform in for Ubuntu

--tags: use locals for common tags and add Name tag for your instance which has to be unique use environment variable

--Security Group: create and attach security group for your server

--call iam_instance_profile argument provide name of IAM instance profile of the following resource below

2- Security Group:
--Create aws_security_group resource

--Create aws_security_group_rule resource for ingress: with ports open to 22 to home IP and port 80 to the world

--Create aws_security_group_rule resource for egress: with ports open 443 to the world

--Tags: use locals common tags as well as unique Name tag for your security group use environment variable for it

3-IAM Role:

--Create aws_iam_role resource give local name tf-role

--Add tags: use locals for common tags and merge with Name tag make sure to use environment variable in it.

--Create aws_iam_instance_profile resource for tf-role and attach it

--Call argument: assume_role_policy in a tf-role resource and call data source aws_iam_policy_document

--Create aws_iam_policy resource, reference data source aws_iam_policy_document in it.

--Create aws_iam_policy_attachment resource and attach your iam policy to tf-role

--aws_iam_policy_document has to contain:


  FOLDER-2 S3

S3 bucket:

--Create S3 bucket aws_s3_bucket resource with local name "remote_state"

--Create aws_s3_bucket_versioning resource

--Create aws_s3_bucket_server_side_encryption_configuration apply for the bucket "AES256" encryption

--Create aws_s3_bucket_policy resource and data source it:



How to Use these configuration folders: 

1- Create the resources of the 1st folder by backend "local".

2- Create only the S3 bucket by using backend "local". 

   use: $ terraform plan -target=aws_s3_bucket.backend -out=/tmp/tfplan

        $ terraform apply /tmp/tfplan

3- Change the backend to "s3" (use the bucket created in Step-2); it will migrate local backend to s3 and provision the other resources.

4- Go back to EC2 folder and change the local backend to "S3" (use the bucket created in Step-2); it will migrate local backend to s3.


Congratulations! Both of your backends are in S3 now. 
