# AWS IaC Sandbox (Local Only)

This project lets you practice and showcase DevOps skills by provisioning AWS-like infrastructure locally using Terraform and LocalStack.

## Purpose
- Use Infrastructure as Code (IaC) safely and freely
- Emulate AWS services (EC2, S3, IAM, etc.) with LocalStack
- Modular, reusable Terraform code

## Project Structure
- `terraform/` — Terraform configuration files
- `modules/` — Custom Terraform modules
- `scripts/` — Automation scripts

## Quick Start
1. Clone this repository
2. (Setup and usage instructions will be added as the project develops)

## LocalStack Usage

Start LocalStack (in the background):
```sh
docker-compose up -d
```

Stop LocalStack:
```sh
docker-compose down
```

- LocalStack will expose AWS-compatible endpoints on port 4566.
- Data will persist in the `localstack/` directory.
- You can view logs using:
```sh
docker-compose logs -f
```

## Extending LocalStack

To enable additional AWS services in LocalStack:

1. Edit the `SERVICES` environment variable in `docker-compose.yml`.
   - For example, to add Lambda and DynamoDB:
     ```yaml
     environment:
       - SERVICES=s3,ec2,iam,lambda,dynamodb
     ```
2. Save the file and restart LocalStack:
   ```sh
   docker-compose down
   docker-compose up -d
   ```

You can find the full list of supported services in the [LocalStack documentation](https://docs.localstack.cloud/references/aws-api-support/).