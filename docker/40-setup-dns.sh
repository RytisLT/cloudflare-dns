#!/bin/bash
if [ -z "$cloudflare_dns_token" ]; then
    echo cloudflare_dns_token not set
    exit 1
else
    sed -i "s/cloudflare_dns_token=/cloudflare_dns_token=$cloudflare_dns_token/g" /root/dns.sh
    sed -i "s/cloudflare_zone_id=/cloudflare_zone_id=$cloudflare_zone_id/g" /root/dns.sh
    sed -i "s/domain_name=/domain_name=$domain_name/g" /root/dns.sh
fi