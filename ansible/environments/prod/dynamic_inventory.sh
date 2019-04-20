#!/bin/bash
TFPATH=../terraform/
cd $TFPATH

get_vm_ip(){
        ip=`terraform output $1`
        echo $ip
}

GITLAB_IP=$(get_vm_ip "gitlab_external_ip")
DEV_IP=$(get_vm_ip "dev_external_ip")
PROD_IP=$(get_vm_ip "prod_external_ip")

echo -e {
echo -e     "\t\"gitlab\": {"
echo -e       "\t\t \"hosts\": [\"gitlab\"],"
echo -e        "\t\t\"vars\": {"
echo -e            "\t\t\t\"ansible_host\": \"$GITLAB_IP\""
echo -e        " \t\t}"
echo -e    "\t},"
echo -e    "\t\"gitlab-runners\": {"
echo -e        "\t\t\"hosts\": [\"dev\",\"prod\"],"
echo -e   "\t },"
echo -e     "\t\"_meta\": {"
echo -e        "\t\t\"hostvars\": {"
echo -e         "\t\t\t\"dev\": {"
echo -e                "\t\t\t\t\"ansible_host\":\"$DEV_IP\""
echo -e     "\t\t\t},"
echo -e         "\t\t\t\"prod\": {"
echo -e                "\t\t\t\t\"ansible_host\":\"$PROD_IP\""
echo -e     "\t\t\t}"
echo -e "\t\t}"
echo -e "\t}"
echo -e }
