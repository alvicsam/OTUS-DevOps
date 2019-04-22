#!/bin/bash
# $1 - gitlab registration token
# $2 - docker hub login
GITLAB_IP=`cd terraform/ && terraform output gitlab_external_ip`
GITLAB_REG_TOKEN=$1
DOCKER_HUB_LOGIN=$2
#Configuring gitlab-runners
cd ansible/
echo "---" > environments/prod/group_vars/gitlab-runners.yml
echo "gitlab_runner_registration_token: '$GITLAB_REG_TOKEN'" >> environments/prod/group_vars/gitlab-runners.yml
echo "gitlab_runner_coordinator_url: 'http://$GITLAB_IP'" >> environments/prod/group_vars/gitlab-runners.yml
ansible-playbook playbooks/gitlab-runners.yml
ansible-playbook playbooks/docker-login.yml
cd ../temp/crawler
echo "variables:" > .gitlab-ci.yml
echo "    DOCKERHUBUSER: $2" >> .gitlab-ci.yml
cat ../../files/.gitlab-ci.yml >> .gitlab-ci.yml
git add .gitlab-ci.yml
git commit -m "added .gitlab-ci.yml"
echo "DOCKERHUBUSER=$DOCKER_HUB_LOGIN" > .env
cp ../../files/docker-compose-apps.yml docker-compose.yml
git add .env
git add docker-compose.yml
git commit -m "added docker-compose"
git push

