FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server sudo && \
    rm -rf /var/lib/apt/lists/*

# Create the low-privilege user.
RUN useradd -rm -d /home/ubuntu -s /bin/bash -u 1000 jack && \
    echo "jack:YvFWPeC7sTWJdaYQ" | chpasswd

# Flag readable only by root.
COPY flag /root/flag.txt
RUN chmod 400 /root/flag.txt

# Vulnerability: /etc/passwd is writable by unprivileged users.
RUN chmod 0646 /etc/passwd

RUN mkdir -p /run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
