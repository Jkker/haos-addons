# GitHub Actions Workflow for Home Assistant Add-on

## Overview

This workflow automatically builds and publishes the Cloudflare DDNS add-on to GitHub Container Registry (GHCR) for all supported architectures.

## Features

- **Multi-architecture builds**: Builds for `aarch64`, `amd64`, `armhf`, `armv7`, and `i386`
- **Automatic publishing**: Publishes to `ghcr.io/jkker/addon-cloudflare-ddns`
- **Multi-arch manifest**: Creates a unified manifest for all architectures
- **Quality checks**: Lints Dockerfile and shell scripts
- **Semantic versioning**: Supports version tags (e.g., `v1.0.0`)

## Workflow Triggers

- **Push to main**: Builds and publishes with `latest` tag
- **Version tags**: Builds and publishes with semantic version tags (e.g., `v1.0.0`)
- **Pull requests**: Builds without publishing (for testing)
- **Manual**: Can be triggered manually via GitHub Actions UI

## Image Naming

Images are published to: `ghcr.io/jkker/addon-cloudflare-ddns`

With tags:
- `latest` - Latest build from main branch
- `v1.0.0` - Semantic version tags
- `1.0.0` - Version without 'v' prefix
- `1.0` - Major.minor version
- `1` - Major version only

Each architecture gets a suffix during build (e.g., `-amd64`), then a multi-arch manifest is created.

## Usage

### First-time Setup

1. **Enable GitHub Container Registry**:
   - Go to your repository settings
   - Navigate to "Actions" → "General"
   - Under "Workflow permissions", ensure "Read and write permissions" is selected

2. **Make Package Public** (after first build):
   - Go to your GitHub profile → "Packages"
   - Find `addon-cloudflare-ddns`
   - Change visibility to "Public"

### Publishing a New Version

1. Update `version` in `cloudflare-ddns/config.yaml`
2. Commit and push:
   ```bash
   git add cloudflare-ddns/config.yaml
   git commit -m "Bump version to 1.0.1"
   git push
   ```

3. Create and push a version tag:
   ```bash
   git tag v1.0.1
   git push origin v1.0.1
   ```

4. The workflow will automatically build and publish

### Using the Add-on

Add this repository to Home Assistant:
```
https://github.com/jkker/haos-addons
```

The add-on will now install correctly from GHCR.

## Manual Build (Optional)

You can also build locally using the Home Assistant builder:

```bash
docker run \
  --rm \
  --privileged \
  -v ~/.docker/config.json:/root/.docker/config.json:ro \
  -v $(pwd)/cloudflare-ddns:/data \
  ghcr.io/home-assistant/amd64-builder \
  --all \
  -t /data
```

## Troubleshooting

### Build Failures

- Check the Actions tab in GitHub for detailed logs
- Ensure all required files are present in `cloudflare-ddns/`
- Verify `config.yaml` syntax is valid

### Installation Issues

- Ensure the package is public in GHCR
- Verify the image name matches in `config.yaml`
- Check Home Assistant supervisor logs
