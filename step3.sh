#!/bin/bash
# $1 - gitlab registration token
GITLAB_IP=`cd terraform/ && terraform output gitlab_external_ip`
GITLAB_REG_TOKEN=$1
#Configuring gitlab-runners
cd ansible/
echo "---" > environments/prod/group_vars/gitlab-runners.yml
echo "gitlab_runner_registration_token: '$GITLAB_REG_TOKEN'" >> environments/prod/group_vars/gitlab-runners.yml
echo "gitlab_runner_coordinator_url: 'http://$GITLAB_IP'" >> environments/prod/group_vars/gitlab-runners.yml
ansible-playbook playbooks/gitlab-runners.yml
cd ../temp/crawler
cp ../../files/.gitlab-ci.yml .gitlab-ci.yml
git add .gitlab-ci.yml
git commit -m "added .gitlab-ci.yml"
git push

