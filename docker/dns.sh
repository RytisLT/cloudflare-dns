#!/bin/bash

# Configuration
cloudflare_dns_token=
cloudflare_zone_id=
domain_name=

# Get current external IP
external_ip=$(curl -s "https://ifconfig.me") &&

# Get record Id for domain

record_id=$(curl -s -X  GET "https://api.cloudflare.com/client/v4/zones/${cloudflare_zone_id}/dns_records?type=A&name=${domain_name}" \
    -H "Authorization: Bearer ${cloudflare_dns_token}" \
-H "Content-Type:application/json" | jq '.result[] | .id' | tr -d '"')

# Get Cloudflare DNS IP for ***
fetched_dns_data=$(curl -s -X GET \
    --url https://api.cloudflare.com/client/v4/zones/${cloudflare_zone_id}/dns_records/${record_id} \
    -H "Content-Type: application/json" \
-H "Authorization: Bearer ${cloudflare_dns_token}") &&

# Parse IP from JSON responce
cloudflare_ip=$(echo $fetched_dns_data | jq '.result.content' | tr -d '"') &&

# Log current IP info
echo "$(date '+%Y-%m-%d %H:%M:%S') - Current External IP is $external_ip, Cloudflare DNS IP is $cloudflare_ip" &&

# Update DNS if IP has changed
if [ "$cloudflare_ip" != "$external_ip" ] && [ -n "$external_ip" ]; then
    echo "Your IP has changed! Updating DNS on Cloudflare"
    curl -s -X PUT \
    --url "https://api.cloudflare.com/client/v4/zones/${cloudflare_zone_id}/dns_records/${record_id}" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${cloudflare_dns_token}" \
    -d '{
    "content": "'"${external_ip}"'",
    "name": "'"${domain_name}"'",
    "type": "A",
    "ttl": 1
    }' > /dev/null
    echo "Changed IP from ${cloudflare_ip} to ${external_ip}"
fi
