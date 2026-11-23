FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-server sudo cron python3 python-is-python3 multitime && \
    rm -rf /var/lib/apt/lists/*

# Create the low-privilege user.
RUN useradd -rm -d /home/ubuntu -s /bin/bash -u 1000 time && \
    echo "time:EDBVCjNFAAzYedCX" | chpasswd

# Create the wormhole user used for the second escalation step.
RUN useradd -rm -d /home/wormhole -s /bin/bash -u 1001 wormhole

# Allow the time user to run multitime as wormhole.
RUN echo 'time ALL=(wormhole) /usr/bin/multitime' >> /etc/sudoers

# Vulnerable cron job target: writable by everyone.
COPY deploy/time-travel.py /home/wormhole/time-travel.py
RUN chown root:root /home/wormhole/time-travel.py && chmod 0777 /home/wormhole/time-travel.py

# Install the cron job run by root every minute.
RUN echo '* * * * * root /usr/bin/python /home/wormhole/time-travel.py' >> /etc/crontab

# Flag readable only by root.
COPY flag /root/flag.txt
RUN chmod 400 /root/flag.txt

# Service startup scripts.
COPY deploy/start-cron /usr/sbin/start-cron
COPY deploy/start-services /usr/start-services
RUN chmod +x /usr/sbin/start-cron /usr/start-services

RUN mkdir -p /run/sshd

EXPOSE 22
ENTRYPOINT ["/bin/sh", "-c", "/usr/start-services"]
