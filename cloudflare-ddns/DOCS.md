# Home Assistant Add-on: Cloudflare DDNS

A feature-rich and robust Cloudflare DDNS updater with a small footprint. This add-on automatically detects your machine's public IP addresses and updates DNS records using the Cloudflare API.

## About

This add-on wraps the excellent [favonia/cloudflare-ddns](https://github.com/favonia/cloudflare-ddns) project, bringing its powerful features to Home Assistant OS:

- **Efficient**: Small Docker image (<5 MB compressed)
- **Complete Domain Support**: Handles internationalized and wildcard domains
- **IPv4 & IPv6**: Full support for both IP versions
- **Cloudflare Features**: Proxying, DNS comments, WAF lists
- **Notifications**: Healthchecks, Uptime Kuma, Shoutrrr integration
- **Security Focused**: HTTPS/DoH only for IP detection

## Installation

1. Add this repository to your Home Assistant instance
2. Install the "Cloudflare DDNS" add-on
3. Configure the add-on (see Configuration section)
4. Start the add-on

## Configuration

### Required Settings

**Option: `cloudflare_api_token`**

Your Cloudflare API token. Create one at [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens) using the **Edit zone DNS** template.

Required permissions:
- **Zone - DNS - Edit** (for updating DNS records)
- **Account - Account Filter Lists - Edit** (optional, only needed for WAF lists)

**Option: `domains`**

List of fully qualified domain names to manage for both IPv4 and IPv6.

Example:
```yaml
domains:
  - example.com
  - www.example.com
  - subdomain.example.org
```

### Optional Settings

**Option: `ip4_domains` / `ip6_domains`**

Manage specific domains for IPv4 (A records) or IPv6 (AAAA records) separately.

**Option: `proxied`** (default: `false`)

Enable Cloudflare proxying to cache webpages and hide your IP address. Set to `true` to enable.

⚠️ Only enable if you're running a web server. Non-HTTP(S) traffic cannot be proxied.

**Option: `ip4_provider` / `ip6_provider`** (default: `cloudflare.trace`)

How to detect your public IP address:
- `cloudflare.trace`: Use Cloudflare's debugging page (default, recommended)
- `cloudflare.doh`: Use Cloudflare DNS-over-HTTPS
- `local`: Use local network interfaces (requires `host_network: true`)
- `none`: Disable IPv4 or IPv6 completely

**Option: `update_cron`** (default: `@every 5m`)

Schedule for checking and updating IP addresses. Use cron syntax or special values:
- `@every 5m` - Every 5 minutes
- `@hourly` - Every hour
- `@daily` - Every day
- `0 */4 * * *` - Every 4 hours

**Option: `timezone`** (default: `UTC`)

Timezone for logging and scheduling. Examples: `America/New_York`, `Europe/London`, `Asia/Tokyo`

**Option: `ttl`** (default: `1`)

Time-to-live for new DNS records in seconds. Value of `1` means "automatic" in Cloudflare.

**Option: `record_comment`**

Comment to add to newly created DNS records.

**Option: `cache_expiration`** (default: `6h`)

How long to cache Cloudflare API responses. Reduces API calls but may delay detection of manual changes.

**Option: `delete_on_stop`** (default: `false`)

Delete managed DNS records when the add-on stops. Generally not recommended.

### Monitoring & Notifications

**Option: `healthchecks_url`**

Healthchecks.io ping URL for monitoring. Example: `https://hc-ping.com/<uuid>`

**Option: `uptimekuma_url`**

Uptime Kuma push URL for monitoring. Example: `https://your-server/push/<id>`

**Option: `shoutrrr_urls`**

List of Shoutrrr URLs for notifications (Discord, Slack, email, etc.). See [Shoutrrr documentation](https://containrrr.dev/shoutrrr/latest/services/overview/).

Example:
```yaml
shoutrrr_urls:
  - discord://token@id
  - smtp://username:password@host:port/?from=sender@example.com&to=recipient@example.com
```

### Advanced Options

**Option: `waf_lists`**

Cloudflare WAF lists to manage with detected IP addresses. Format: `<account-id>/<list-name>`

Example:
```yaml
waf_lists:
  - 0123456789abcdef0123456789abcdef/home-ips
```

**Option: `detection_timeout`** (default: `5s`)

Timeout for IP detection per attempt.

**Option: `update_timeout`** (default: `30s`)

Timeout for DNS record updates per domain.

**Option: `update_on_start`** (default: `true`)

Check and update immediately when the add-on starts.

**Option: `emoji`** (default: `true`)

Use emojis in log messages.

**Option: `quiet`** (default: `false`)

Reduce logging output.

## Example Configuration

### Basic Setup

```yaml
cloudflare_api_token: "your-api-token-here"
domains:
  - example.com
  - www.example.com
proxied: true
update_cron: "@every 10m"
timezone: "America/New_York"
```

### Advanced Setup with Monitoring

```yaml
cloudflare_api_token: "your-api-token-here"
domains:
  - home.example.com
ip4_domains:
  - ipv4-only.example.com
ip6_domains:
  - ipv6-only.example.com
proxied: false
update_cron: "0 */6 * * *"
timezone: "Europe/London"
ttl: 300
record_comment: "Managed by Home Assistant"
healthchecks_url: "https://hc-ping.com/your-uuid"
shoutrrr_urls:
  - discord://token@id
emoji: true
quiet: false
```

### Disable IPv6

If your network doesn't support IPv6, disable it to avoid error messages:

```yaml
cloudflare_api_token: "your-api-token-here"
domains:
  - example.com
ip6_provider: none
```

## Support

For issues related to:
- **The add-on itself**: Open an issue in this repository
- **Cloudflare DDNS features**: See [favonia/cloudflare-ddns](https://github.com/favonia/cloudflare-ddns)
- **Home Assistant**: See [Home Assistant Community](https://community.home-assistant.io/)

## Credits

This add-on is a wrapper around the excellent [cloudflare-ddns](https://github.com/favonia/cloudflare-ddns) project by [@favonia](https://github.com/favonia).
