# Home Assistant Add-on: Cloudflare DDNS

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

A feature-rich and robust Cloudflare DDNS updater for Home Assistant.

## About

This add-on automatically updates your Cloudflare DNS records with your current public IP address. It's perfect for running services at home with a dynamic IP address.

Key features:
- 🤏 **Tiny footprint** - Less than 5MB Docker image
- 🌍 **Full domain support** - Handles internationalized and wildcard domains
- ⚡ **IPv4 & IPv6** - Comprehensive support for both protocols
- 😶‍🌫️ **Cloudflare proxying** - Hide your IP and cache content
- 🩺 **Monitoring** - Healthchecks.io and Uptime Kuma integration
- 📣 **Notifications** - Discord, Slack, email, and more via Shoutrrr
- 🛡️ **Secure** - Only uses HTTPS/DoH for IP detection

This add-on wraps the excellent [favonia/cloudflare-ddns](https://github.com/favonia/cloudflare-ddns) project.

## Installation

1. Click the button below or add this repository to your Home Assistant instance:

   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FJkker%2Fhaos-addons)

2. Install the "Cloudflare DDNS" add-on
3. Configure your Cloudflare API token and domains
4. Start the add-on
5. Check the logs to verify everything is working

## Configuration

See the [Documentation](DOCS.md) for detailed configuration options.

### Quick Start Example

```yaml
cloudflare_api_token: "your-api-token-here"
domains:
  - example.com
  - www.example.com
proxied: true
```

## Documentation

Full documentation is available in [DOCS.md](DOCS.md).

## Support

- For add-on issues: [Open an issue][issue]
- For Home Assistant: [Community Forum][forum]
- For cloudflare-ddns features: [Upstream project][upstream]

## License

This add-on is licensed under the Apache License 2.0.

The wrapped [cloudflare-ddns](https://github.com/favonia/cloudflare-ddns) project is licensed under the Apache License 2.0.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[forum]: https://community.home-assistant.io/
[issue]: https://github.com/Jkker/haos-addons/issues
[upstream]: https://github.com/favonia/cloudflare-ddns
