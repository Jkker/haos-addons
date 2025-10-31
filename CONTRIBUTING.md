# Contributing to Cloudflare DDNS Add-on

Thank you for your interest in contributing! Here are some guidelines to help you get started.

## Development Setup

### Prerequisites
- Git
- Docker
- Home Assistant OS (for testing) or Home Assistant Core with Supervisor

### Local Development

1. Fork and clone the repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/haos-addons.git
   cd haos-addons
   ```

2. Make your changes to the addon files in `cloudflare-ddns/`

3. Test your changes:
   - Add the local repository to your Home Assistant instance
   - Install the addon
   - Check logs for errors

### File Structure

```
cloudflare-ddns/
├── config.yaml          # Addon configuration and schema
├── Dockerfile           # Container build instructions
├── build.yaml           # Build configuration for different architectures
├── run.sh               # Main entry script
├── apparmor.txt         # AppArmor security profile
├── DOCS.md              # User documentation
├── README.md            # Addon README
├── CHANGELOG.md         # Version history
└── translations/
    └── en.yaml          # English translations
```

## Making Changes

### Code Style
- Use shellcheck for bash scripts
- Follow existing code formatting
- Add comments for complex logic

### Documentation
- Update DOCS.md for user-facing changes
- Update README.md if needed
- Add entries to CHANGELOG.md

### Commit Messages
Use conventional commits format:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `chore:` for maintenance tasks

Example: `feat: add support for custom IP providers`

## Testing

### Manual Testing
1. Install the addon in Home Assistant
2. Test with various configurations
3. Check logs for errors
4. Verify DNS records are updated correctly

### Test Cases
- IPv4 only configuration
- IPv6 only configuration
- Both IPv4 and IPv6
- Multiple domains
- Different update schedules
- Healthchecks integration
- Notification services

## Submitting Changes

1. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit:
   ```bash
   git add .
   git commit -m "feat: your feature description"
   ```

3. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

4. Create a Pull Request on GitHub

### Pull Request Guidelines
- Describe what your changes do
- Reference any related issues
- Include test results
- Update documentation as needed

## Reporting Issues

When reporting issues, please include:
- Home Assistant version
- Addon version
- Relevant configuration (redact sensitive data)
- Log output
- Steps to reproduce

## Questions?

Feel free to open an issue for questions or discussions!

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.
