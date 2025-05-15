#!/bin/env bash

# #######
# Author: LUFFY SENPAI
# Date: 16th-March-2025
# supported_servies: ec2, s3, rds, ebs, elb
# usage: ./aws-resource-list.sh <region> <ec2>
# example: ./aws-resource-list.sh ap-south-1 ec2

profile=super

# check if the required number of arguments are passed
if [ $# -ne 2 ]; then
    echo "usage: $0 <region> <service_name>"
    exit 1
fi


# check if aws cli is installed
if [ ! command -v aws ] &> /dev/null; then
    echo "AWS CLI is not installed. please install it and try again."
    exit 1
fi

# check if aws credentials is configured
if [ ! -d ~/.aws ]; then
    echo "AWS Credentials are not configured. please run 'aws configure' to set it up"
    exit 1
fi

case $2 in 
  ec2)
    aws ec2 describe-instances --region $1 --profile="$profile"
    ;;
  s3)
    aws s3api list-buckets --region $1 --profile="$profile"
    ;;
  rds)
    aws rds describe-db-instances --region $1 --profile="$profile"
    ;;
  ebs)
    aws ec2 describe-volumes --region $1 --profile="$profile"
    ;;
  elb)
    aws elb describe-load-balancers --region $1 --profile="$profile"
    ;;
*)
    echo "invalid servie name, please provide only the supported services"
    exit 1
    ;;
esac