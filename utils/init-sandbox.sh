#!/bin/bash
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
Color_Off='\033[0m'

# AWS CLI Installation
AWS_CLI=/sandbox/utils/aws-cli
AWS_TMP=/sandbox/utils/aws-tmp

if [ -d "$AWS_CLI" ]; then
  echo '\033[1;92m'
  echo '+ AWS directory exists and must be operational. If not remove with rm -fR '$AWS_CLI
else
  mkdir $AWS_TMP;
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$AWS_TMP/awscliv2.zip"
  unzip $AWS_TMP/awscliv2.zip -d $AWS_TMP
  rm -f $AWS_TMP/awscliv2.zip
  $AWS_TMP/aws/install -i $AWS_CLI -b $AWS_CLI
  rm -fR $AWS_TMP
fi

# Terraform CLI installation
TF_CLI=/sandbox/utils/tf
if [ -d "$TF_CLI" ]; then
  echo '+ Terraforn directory exists and must be operational. If not remove with rm -fR '$TF_CLI
else
  mkdir $TF_CLI
  curl "https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip" -o "$TF_CLI/terraform_1.1.7_linux_amd64.zip"
  unzip $TF_CLI/terraform_1.1.7_linux_amd64.zip -d $TF_CLI
  rm -f $TF_CLI/terraform_1.1.7_linux_amd64.zip
fi

echo '+ Generate new ~/.bashrc file'
cp -v /sandbox/utils/.bashrc ~

echo '\033[0m'
echo "alias ll='ls -al'">>~/.bashrc
echo "alias aws='$AWS_CLI/v2/current/bin/aws'">>~/.bashrc
echo "alias terraform='$TF_CLI/terraform'">>~/.bashrc
echo "alias tf='terraform'">>~/.bashrc
exit