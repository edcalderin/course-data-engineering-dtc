```bash
export GOOGLE_CREDENTIALS=$(pwd)/keys/credentials.json
echo $GOOGLE_CREDENTIALS
terraform init
terraform plan
terraform apply
```