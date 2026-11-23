FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server sudo build-essential && \
    rm -rf /var/lib/apt/lists/*

# Create the low-privilege user.
RUN useradd -rm -d /home/maverick -s /bin/bash -u 1000 maverick && \
    echo "maverick:jXztBtEWKYRMrjAF" | chpasswd

# Build and install the vulnerable SUID binary.
RUN mkdir -p /home/maverick/scripts
COPY deploy/favorite-quote.c /tmp/favorite-quote.c
RUN gcc /tmp/favorite-quote.c -o /home/maverick/scripts/favorite-quote && \
    chown root:root /home/maverick/scripts/favorite-quote && \
    chmod 4755 /home/maverick/scripts/favorite-quote && \
    rm -f /tmp/favorite-quote.c

# Flag readable only by root.
COPY flag /root/flag.txt
RUN chmod 400 /root/flag.txt

RUN mkdir -p /run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
