# Setup and Deployment Guide

## Quick Start

### 1. Initialize Git Repository

```bash
cd /home/jkker/code/haos-addons
git init
git add .
git commit -m "feat: initial commit - cloudflare-ddns addon"
```

### 2. Create GitHub Repository

Using GitHub CLI:
```bash
gh repo create Jkker/haos-addons --public --description "Home Assistant add-on for Cloudflare DDNS" --source=. --remote=origin
git push -u origin main
```

Or manually:
1. Go to https://github.com/new
2. Create repository named `haos-addons`
3. Don't initialize with README (we already have one)
4. Run:
   ```bash
   git remote add origin https://github.com/Jkker/haos-addons.git
   git branch -M main
   git push -u origin main
   ```

### 3. Add Repository to Home Assistant

1. Open Home Assistant
2. Go to **Settings** → **Add-ons** → **Add-on Store**
3. Click the three dots (⋮) in the top right
4. Select **Repositories**
5. Add: `https://github.com/Jkker/haos-addons`
6. Click **Add**

### 4. Install the Add-on

1. Find "Cloudflare DDNS" in the add-on store
2. Click on it and select **Install**
3. Wait for installation to complete
4. Go to the **Configuration** tab

### 5. Configure the Add-on

Minimum configuration:
```yaml
cloudflare_api_token: "your-api-token-here"
domains:
  - example.com
  - www.example.com
```

Get your API token:
1. Go to https://dash.cloudflare.com/profile/api-tokens
2. Click **Create Token**
3. Use **Edit zone DNS** template
4. Select the zones you want to manage
5. Create token and copy it

### 6. Start the Add-on

1. Go to the **Info** tab
2. Click **Start**
3. Enable **Start on boot** if desired
4. Check the **Log** tab to verify it's working

## Advanced Configuration

### IPv4 or IPv6 Only

Disable IPv6 if your network doesn't support it:
```yaml
cloudflare_api_token: "your-token"
domains:
  - example.com
ip6_provider: none
```

### Custom Update Schedule

Update every hour instead of every 5 minutes:
```yaml
cloudflare_api_token: "your-token"
domains:
  - example.com
update_cron: "@hourly"
```

### Enable Monitoring

With Healthchecks.io:
```yaml
cloudflare_api_token: "your-token"
domains:
  - example.com
healthchecks_url: "https://hc-ping.com/your-uuid"
```

With Discord notifications:
```yaml
cloudflare_api_token: "your-token"
domains:
  - example.com
shoutrrr_urls:
  - "discord://token@id"
```

## Troubleshooting

### Check Logs

The logs will show:
- IP address detection
- DNS record updates
- Any errors

Look for:
- ✅ Success indicators
- ⚠️ Warnings
- ❌ Errors

### Common Issues

**"Failed to detect IP address"**
- Check your network connection
- Try a different IP provider (cloudflare.doh instead of cloudflare.trace)
- If using IPv6, make sure your network supports it or disable with `ip6_provider: none`

**"API token is invalid"**
- Verify your token at https://dash.cloudflare.com/profile/api-tokens
- Make sure it has **Zone - DNS - Edit** permission
- Check the token isn't expired

**"Domain not found"**
- Verify the domain exists in your Cloudflare account
- Check for typos in the domain name
- Ensure the domain's zone is accessible with your API token

**IPv6 not working**
- The addon uses `host_network: true` for proper IPv6 support
- This is required and enabled by default

### Enable Debug Logging

Set quiet mode to false and emoji to true for detailed logs:
```yaml
emoji: true
quiet: false
```

## Updating the Add-on

When a new version is released:
1. Go to the Add-on page in Home Assistant
2. If an update is available, you'll see an **Update** button
3. Click it to update
4. Restart the add-on after updating

## Development and Testing

### Local Testing

1. Make changes to addon files
2. Commit changes:
   ```bash
   git add .
   git commit -m "fix: your change description"
   git push
   ```
3. In Home Assistant:
   - Go to Add-on Store
   - Click three dots → **Reload**
   - Update the add-on
   - Restart it

### Build Configuration

The addon supports these architectures:
- aarch64 (ARM 64-bit, e.g., Raspberry Pi 4)
- amd64 (Intel/AMD 64-bit)
- armhf (ARM 32-bit hard float)
- armv7 (ARM v7 32-bit)
- i386 (Intel/AMD 32-bit)

Home Assistant automatically builds for the correct architecture.

## Publishing

To publish your addon:

1. Ensure all files are committed
2. Tag a release:
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```
3. Create a GitHub release from the tag
4. Users can add your repository URL to their Home Assistant instance

## Support

- **Issues**: https://github.com/Jkker/haos-addons/issues
- **Upstream**: https://github.com/favonia/cloudflare-ddns
- **Home Assistant Community**: https://community.home-assistant.io/

## Next Steps

Consider adding:
- Custom icons (icon.png and logo.png)
- GitHub Actions for automated testing
- More example configurations in DOCS.md
- Screenshots and animated GIFs for README
- Support for more notification services
