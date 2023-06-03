# WK7_Terraform/4_Modules

Change the following to your own:

**Examples**

- applications/examples/backend.tf: bucket/key
- Jenkinsfile: AWS_Cred

**API GW + Lambda +Dynamo**

- applications/helloworld-api-gateway-lambda/backend.tf: Bucket/key
- applications/helloworld-api-gateway-lambda/main.tf: s3_bucket_name/s3_resources
- Jenkinsfile: AWS_Cred

**Lambda Files**
- helloworld.zip with index_homework.mjs and lookup.zip with index_getname.mjs need to be uploaded to your lambda s3 bucket before running terraform