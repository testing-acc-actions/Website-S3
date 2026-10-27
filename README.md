# Terraform AWS S3 Static Website

This project uses Terraform to create and manage an Amazon S3 bucket that hosts a static website. It’s a beginner-friendly way to learn Infrastructure as Code (IaC), AWS storage, and basic cloud security.

## Project goals

- Learn how Terraform creates and manages AWS resources.
- Host a static HTML website using Amazon S3.
- Understand S3 static website hosting, public-access settings, and bucket policies.
- Practice Git version control and safely update cloud infrastructure.

## Architecture

The project uses the following components:

- Amazon S3 bucket: Stores the website files.
- S3 static website hosting: Serves the website through an S3 website endpoint.
- Bucket policy: Allows public `s3:GetObject` access to website files when public hosting is enabled.
- Terraform: Defines and manages the AWS infrastructure.
- AWS CLI: Uploads website content to the bucket.

The bucket used during this project was:

`tf-website-learner-16e6b602c04c23b0e55d892e6f`

The website endpoint previously used was:

`http://tf-website-learner-16e6b602c04c23b0e55d892e6f.s3-website.ap-south-1.amazonaws.com`

S3 website endpoints support HTTP, not HTTPS directly. For a production website, consider using Amazon CloudFront with HTTPS and a private S3 bucket configured for controlled origin access.
<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/26ac5eee-5558-4f21-b0c9-ce90ed7c6d0e" />

## Tools used

- AWS account and AWS CLI
- Terraform
- Git and GitHub
- Visual Studio Code

## Project structure

The repository may look like this:

```
terraform-s3-website/
├── main.tf
├── terraform.tf
├── variables.tf
├── website.tf
├── public-access.tf
├── bucket_policy.tf
├── outputs.tf
├── .gitignore
└── website/
    └── index.html
```

Each file has a specific purpose:

- `main.tf` defines the core AWS resources.
- `terraform.tf` configures Terraform and the AWS provider.
- `variables.tf` defines configurable values.
- `website.tf` enables static website hosting.
- `public-access.tf` manages S3 Block Public Access settings.
- `bucket_policy.tf` defines the permissions required to serve public website files.
- `outputs.tf` displays useful values, such as the bucket name, ARN, and website endpoint.
- `website/index.html` contains the website content.
- `.gitignore` prevents local state files and generated files from being added to Git.

The exact responsibilities depend on the current Terraform configuration.

## Prerequisites

Before deploying the project, make sure you have:

1. Terraform installed.
2. AWS CLI installed.
3. An AWS SSO profile with the required permissions.
4. Website files available in the `website/` directory.

To authenticate through AWS IAM Identity Center, run these commands in PowerShell:

```
aws sso login --profile terraform-learner
aws sts get-caller-identity --profile terraform-learner --region ap-south-1
```

The second command confirms which AWS identity your CLI is using.

## Deploying the infrastructure

Open PowerShell in your project directory and run:

```
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```

These commands format your code, initialize Terraform, validate the configuration, and preview the proposed infrastructure changes.

Review the plan carefully before running:

```
terraform apply
```

Do not approve a plan that unexpectedly proposes replacing or deleting your S3 bucket. If the bucket has changed outside Terraform, inspect the AWS resource and Terraform state before making further changes.

## Uploading website content

Once the bucket exists and your AWS profile has permission to upload files, run:

```
aws s3 cp .\website\index.html s3://tf-website-learner-16e6b602c04c23b0e55d892e6f/index.html --profile terraform-learner --region ap-south-1
```

Open the website endpoint from your Terraform outputs in a browser.

When you update `website/index.html` locally, upload it again to publish the changes. Refresh the browser if the updated content does not appear.

## Security considerations

Important: Public access is intentional for this basic static website, but the bucket must not contain private or sensitive information.

- Never upload credentials, confidential files, or personal data.
- Disable public access unless your hosting design specifically requires it.
- If using public hosting, allow only the permissions necessary to serve website objects.
- For production, consider a private S3 bucket behind CloudFront with HTTPS and controlled origin access.
- Use AWS SSO for local authentication instead of long-lived access keys.
- Keep Terraform state files and secrets out of Git.
- Review every Terraform plan before applying changes.

## Cost considerations

Amazon S3 charges may apply for storage, requests, and data transfer. Check current AWS pricing and your account's Free Tier eligibility.

An AWS budget alert notifies you about spending; it does not automatically stop resources or enforce a hard spending limit.

## Cleaning up resources

Before deleting the infrastructure, review the destruction plan:

```
terraform plan -destroy
```

If the plan includes only resources dedicated to this project and you no longer need them, run:

```
terraform destroy
```

Back up any website content you want to keep. S3 bucket deletion may require the bucket to be empty, and deleting the bucket removes its hosted content.

## Current project status

The website was previously confirmed to load successfully in a browser. Before using this README as an operational guide, verify that the bucket, website configuration, bucket policy, Terraform state, and endpoint still match the current AWS environment.
