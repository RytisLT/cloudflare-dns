# Cloudflare DNS A Record Updater

This Docker container updates the A record for a specified domain in Cloudflare DNS. It uses the Cloudflare API to perform the update, ensuring that your domain always points to the correct IP address.

## Features

- Updates A record for a given domain.
- Uses Cloudflare API for DNS management.
- Simple setup and configuration.

## Requirements

- Docker
- Cloudflare API Token with DNS Edit permissions
- Domain registered in Cloudflare

## Environment Variables

The following environment variables must be set to configure the container:

- `cloudflare_dns_token`: Your Cloudflare API token.
- `cloudflare_zone_id`: The Zone ID of your Cloudflare domain.
- `domain_name`: The domain name to update (e.g., `example.com`).

## Usage

1. **Run the Container**

    ```bash
    docker run -d \
        -e cloudflare_dns_token=your_cloudflare_api_token \
        -e cloudflare_zone_id=your_cloudflare_zone_id \
        -e domain_name=example.com \
        --name cloudflare-dns-updater \
        ghcr.io/rytislt/cloudflare-dns
    ```

2. **Check Logs**

    To ensure everything is working, check the logs:

    ```bash
    docker logs -f cloudflare-dns-updater
    ```
3. **Profit**
