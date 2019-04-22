#!/bin/bash
# $1 - gitlab token
# $2 - gitlab password
#creating project crawler
GITLAB_IP=`cd terraform/ && terraform output gitlab_external_ip`
GITLAB_TOKEN=$1
GITLAB_PASSWORD=$2
curl --header "PRIVATE-TOKEN: $1" -X POST "http://$GITLAB_IP/api/v4/projects?name=crawler&description=hello_otus&initialize_with_readme=true"
rm -rf temp/*
cd temp/
git clone https://github.com/express42/search_engine_crawler
git clone https://github.com/express42/search_engine_ui
git clone http://root:$GITLAB_PASSWORD@$GITLAB_IP/root/crawler.git
pwd
rm -rf search_engine_crawler/.git
rm -rf search_engine_ui/.git
mv -f search_engine_crawler/ crawler/
mv -f search_engine_ui/ crawler/
cd crawler/
cp ../../files/Dockerfile-app search_engine_crawler/Dockerfile
cp ../../files/Dockerfile-ui search_engine_ui/Dockerfile
mkdir rabbit
mkdir rabbit/data
cp ../../files/definitions.json rabbit/definitions.json
cp ../../files/rabbitmq.config rabbit/rabbitmq.config
git add *
git commit -m "init"
git push

