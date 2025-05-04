#!/usr/bin/env bash

set -e
set -o pipefail

[[ -z $1 || -z $2 || -z $3 ]] && echo "Not Informed: [ keyname | account-alias | environment  ]" && exit 1;
 
key_name=$1
account_alias=$2
environment=$3

ssh-keygen -t rsa -C "${key_name}" -f ${account_alias}/${environment}/key_pair.txt
