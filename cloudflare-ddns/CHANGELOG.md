# Changelog

All notable changes to this add-on will be documented in this file.

## [1.0.0] - 2024-10-31

### Added
- Initial release of Cloudflare DDNS add-on for Home Assistant
- Support for automatic IPv4 and IPv6 DNS record updates
- Cloudflare proxying support
- Multiple domain management across different zones
- Configurable update schedules with cron expressions
- Multiple IP detection providers (cloudflare.trace, cloudflare.doh, local)
- Healthchecks.io integration for monitoring
- Uptime Kuma integration for monitoring
- Shoutrrr notifications support (Discord, Slack, email, webhooks, etc.)
- WAF lists management (experimental)
- Comprehensive configuration options including:
  - Custom TTL values
  - DNS record comments
  - Timezone configuration
  - Cache expiration settings
  - Timeout configurations
  - Logging controls (emoji, quiet mode)
- Host network mode for proper IPv6 support
- Security-focused design (HTTPS/DoH only for IP detection)
- Based on favonia/cloudflare-ddns upstream project
- Multi-architecture support (aarch64, amd64, armhf, armv7, i386)
- Comprehensive documentation with examples
