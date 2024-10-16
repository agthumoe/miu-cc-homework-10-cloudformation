#!/bin/bash

STACK_NAME=miu-cc-homework-10-cloudformation
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

echo -e "\n\n=========== Building website ==========="
npm install
npm run build

echo -e "\n\n=========== Deploying website ==========="
aws s3 sync ./dist s3://$(aws cloudformation describe-stacks --region $REGION --profile $CLI_PROFILE --stack-name $STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='BucketName'].OutputValue" --output text) --delete --profile $CLI_PROFILE

echo -e "\n\n=========== Website deployed! ==========="