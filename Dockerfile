FROM ubuntu
RUN apt-get update \
    && apt-get -y install cron curl nano jq tini \
    && rm -rf /var/lib/apt/lists/*

COPY docker/40-setup-dns.sh /docker-entrypoint.d/40-setup-dns.sh
RUN chmod a+x /docker-entrypoint.d/40-setup-dns.sh

COPY docker/dns.sh /root/dns.sh
RUN chmod a+x /root/dns.sh
RUN echo "* * * * * root /root/dns.sh > /proc/1/fd/1" >> /etc/crontab

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

LABEL org.opencontainers.image.licenses=MIT

ENTRYPOINT ["/entrypoint.sh"]
CMD ["tini", "/usr/sbin/cron", "--", "-f"]