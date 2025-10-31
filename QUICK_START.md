# Quick Start: Publishing Your Add-on

## Prerequisites

- Git and GitHub CLI (`gh`) installed
- Repository pushed to GitHub
- Docker installed (optional, for local testing)

## Step 1: Initial Setup

The workflow is already configured! Just need to set permissions:

```bash
# Ensure you're logged into GitHub CLI
gh auth login

# Set workflow permissions (if needed)
gh api repos/jkker/haos-addons/actions/permissions -X PUT -f default_workflow_permissions=write
```

## Step 2: Trigger First Build

Option A - Push to main (builds `latest` tag):
```bash
git add .
git commit -m "Setup automated builds"
git push
```

Option B - Create a version tag (builds versioned images):
```bash
# Update version in cloudflare-ddns/config.yaml first
git add cloudflare-ddns/config.yaml
git commit -m "Release v1.0.0"
git tag v1.0.0
git push origin main --tags
```

## Step 3: Make Package Public

After the first build completes:

1. Go to https://github.com/jkker?tab=packages
2. Find `addon-cloudflare-ddns`
3. Click "Package settings"
4. Scroll to "Danger Zone"
5. Click "Change visibility" → "Public"

## Step 4: Install in Home Assistant

1. In Home Assistant, go to:
   - Settings → Add-ons → Add-on Store → ⋮ (top right) → Repositories

2. Add this URL:
   ```
   https://github.com/jkker/haos-addons
   ```

3. Install the Cloudflare DDNS add-on from the store

## Verify Installation

Check that the add-on uses the correct image:

```bash
# View the package
gh api /users/jkker/packages/container/addon-cloudflare-ddns

# List tags
gh api /users/jkker/packages/container/addon-cloudflare-ddns/versions
```

## Updating the Add-on

To release a new version:

```bash
# 1. Update version in config.yaml
nano cloudflare-ddns/config.yaml  # Change version: "1.0.1"

# 2. Commit and tag
git add cloudflare-ddns/config.yaml
git commit -m "Release v1.0.1"
git tag v1.0.1
git push origin main --tags

# 3. GitHub Actions will automatically build and publish
```

## Troubleshooting

### Check workflow status
```bash
gh run list --workflow=build.yaml
gh run view --log  # View latest run logs
```

### Check if images were published
```bash
gh api /users/jkker/packages/container/addon-cloudflare-ddns/versions | jq '.[].metadata.container.tags'
```

### View package details
```bash
gh api /users/jkker/packages/container/addon-cloudflare-ddns | jq '{name, visibility, created_at, updated_at}'
```

### Re-run failed workflow
```bash
gh run rerun <run-id>
```

## What Gets Built

For each push/tag, the workflow:
1. ✅ Lints Dockerfile and shell scripts
2. ✅ Builds images for 5 architectures (aarch64, amd64, armhf, armv7, i386)
3. ✅ Publishes to `ghcr.io/jkker/addon-cloudflare-ddns`
4. ✅ Creates multi-arch manifest
5. ✅ Tags appropriately (latest, version numbers)

Your add-on is now production-ready! 🎉
