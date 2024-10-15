STACK_NAME=aws-s3-iac
REGION=us-east-1
CLI_PROFILE=miu

echo -e "\n\n=========== Deploying package ==========="
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file ./main.yml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM

echo -e "\n\n=========== Deployed! ==========="
aws cloudformation describe-stacks \
    --region $REGION \
    --profile $CLI_PROFILE \
    --stack-name $STACK_NAME \
    --query "Stacks[0].Outputs"