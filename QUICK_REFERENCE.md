# Quick Reference - Cloudflare DDNS Add-on

## Installation (3 Steps)
1. Add repository: `https://github.com/Jkker/haos-addons`
2. Install "Cloudflare DDNS" from Add-on Store
3. Configure and start

## Minimum Configuration
```yaml
cloudflare_api_token: "your-token"
domains:
  - example.com
```

## Common Configurations

### Basic Web Server
```yaml
cloudflare_api_token: "YOUR_TOKEN"
domains:
  - example.com
  - www.example.com
proxied: true
```

### IPv4 Only (No IPv6)
```yaml
cloudflare_api_token: "YOUR_TOKEN"
domains:
  - example.com
ip6_provider: none
```

### Different Schedules
```yaml
cloudflare_api_token: "YOUR_TOKEN"
domains:
  - example.com
update_cron: "@hourly"  # or "@daily", "0 */4 * * *", etc.
```

### With Monitoring
```yaml
cloudflare_api_token: "YOUR_TOKEN"
domains:
  - home.example.com
healthchecks_url: "https://hc-ping.com/your-uuid"
shoutrrr_urls:
  - "discord://token@id"
```

### Separate IPv4/IPv6 Domains
```yaml
cloudflare_api_token: "YOUR_TOKEN"
ip4_domains:
  - ipv4.example.com
ip6_domains:
  - ipv6.example.com
domains:
  - dual.example.com
```

## Get Cloudflare API Token
1. Go to https://dash.cloudflare.com/profile/api-tokens
2. Click "Create Token"
3. Use "Edit zone DNS" template
4. Select zones to manage
5. Create and copy token

## Troubleshooting

### Check Logs
Look for emoji indicators:
- ✅ = Success
- ⚠️ = Warning  
- ❌ = Error

### Common Fixes

**IPv6 errors but no IPv6?**
```yaml
ip6_provider: none
```

**Need more verbose logs?**
```yaml
quiet: false
emoji: true
```

**Updates too frequent?**
```yaml
update_cron: "@hourly"
```

**API errors?**
- Verify token at https://dash.cloudflare.com/profile/api-tokens
- Ensure "Zone - DNS - Edit" permission
- Check token not expired

## File Locations
- Config: `/data/options.json` (auto-managed)
- Logs: Add-on "Log" tab in Home Assistant

## Support
- Issues: https://github.com/Jkker/haos-addons/issues
- Upstream: https://github.com/favonia/cloudflare-ddns
- HA Community: https://community.home-assistant.io/

## Advanced Options

| Option | Values | Description |
|--------|--------|-------------|
| `ip4_provider` | cloudflare.trace, cloudflare.doh, local, none | IPv4 detection |
| `ip6_provider` | cloudflare.trace, cloudflare.doh, local, none | IPv6 detection |
| `update_cron` | cron or @every 5m, @hourly, @daily | Schedule |
| `ttl` | 1-86400 | DNS TTL (1=auto) |
| `proxied` | true/false | Cloudflare proxy |
| `cache_expiration` | 6h, 12h, 24h | API cache time |

## Update Schedule Examples
- `@every 5m` - Every 5 minutes (default)
- `@every 15m` - Every 15 minutes
- `@hourly` - Every hour
- `@daily` - Every day
- `0 */6 * * *` - Every 6 hours
- `0 0 * * *` - Every midnight

## Notification Services (via Shoutrrr)
- Discord: `discord://token@id`
- Slack: `slack://token@channel`
- Email: `smtp://user:pass@host:port/?from=sender&to=recipient`
- More: https://containrrr.dev/shoutrrr/

## Performance
- Image size: ~5 MB compressed
- RAM usage: ~10-20 MB
- CPU: Minimal (only during updates)
- Network: API calls only when needed
