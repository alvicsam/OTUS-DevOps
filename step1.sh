#!/bin/bash

# Full access firewall
MY_IP=`curl ifconfig.so`
RANDOM=`cat /dev/urandom | tr -dc '0-9' | fold -w 5 | head -n 1`
RND=$RANDOM
PROJECT=$1

gcloud compute --project=$PROJECT firewall-rules create allow-all-from-me-$RND --description="Full access from my ip" --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=all --source-ranges=$MY_IP/32
# creating base image with docker and docker-compose
packer build -var-file=packer/variables.json packer/base.json
gcloud compute --project=$PROJECT firewall-rules delete allow-all-from-me-$RND -q
# creating infra
cd terraform
terraform init
terraform apply --auto-approve=true
vm_ip=`terraform output gitlab_external_ip`
for i in {1..60}
 do
  sleep 1
  ssh -i ~/.ssh/appuser appuser@$vm_ip 'echo check' | grep check
  exit_code=`echo $?`
  if [[ $exit_code == 1 ]]; then
   echo Waiting...
   continue
  elif [[ $exit_code == 0 ]]; then
   echo VM is ready.
   break
  fi
 done
echo "ssh -i ~/.ssh/appuser appuser@$vm_ip"
cd ../ansible
ansible all -m ping
ansible-playbook site.yml
