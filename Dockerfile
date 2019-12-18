FROM alpine:3.9

RUN echo "Europe/Moscow" > /etc/timezone
RUN apk add --no-cache openssh-server shadow

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN useradd -M user && echo "user:123" | chpasswd

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sshd", "-D" ]

EXPOSE 22