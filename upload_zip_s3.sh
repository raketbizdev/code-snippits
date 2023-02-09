#!/bin/bash
# Author: Ruel Nopal
# url: rnopal.com

# run the command below
# bash <(curl -s https://raw.githubusercontent.com/raketbizdev/code-snippits/master/upload_zip_s3.sh)

# Check if AWS CLI is installed
if ! command -v aws > /dev/null 2>&1; then
  echo "AWS CLI is not installed. Installing now..."
  sudo apt-get update
  sudo apt-get install awscli
fi

# Check if AWS credentials are set
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS credentials are not set."
  read -p "Enter your AWS access key ID: " AWS_ACCESS_KEY_ID
  read -p "Enter your AWS secret access key: " AWS_SECRET_ACCESS_KEY
  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
fi

# Ask for S3 bucket name
read -p "Enter the name of your S3 bucket: " bucket_name

# Find all zip files in current directory
zip_files=$(find . -name "*.zip")

# Upload each zip file to S3 bucket
for zip_file in $zip_files; do
  echo -n "Uploading $zip_file to S3..."
  aws s3 cp $zip_file s3://$bucket_name/$zip_file &
  pid=$!

  # Show a loading animation while the file is being uploaded
  spin='-\|/'
  i=0
  while kill -0 $pid 2>/dev/null
  do
    i=$(( (i+1) %4 ))
    printf "\rUploading $zip_file to S3... ${spin:$i:1}"
    sleep .1
  done

  if [ $? -eq 0 ]; then
    echo -e "\r$zip_file successfully uploaded to S3.\n"
  else
    echo -e "\rError uploading $zip_file to S3.\n"
  fi
done
