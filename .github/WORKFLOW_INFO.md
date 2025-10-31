# GitHub Actions Workflow for Home Assistant Add-on

This workflow would normally:
1. Build the add-on for all architectures
2. Test the build
3. Publish to GitHub Container Registry

However, Home Assistant add-ons are typically built by the Home Assistant Builder
when users install them, so we'll create a simple validation workflow instead.

For a complete CI/CD setup, you would use:
- home-assistant/builder action for multi-arch builds
- hadolint for Dockerfile linting
- shellcheck for shell script validation

Example workflow structure (not active):

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Lint Dockerfile
        uses: hadolint/hadolint-action@v3.1.0
        with:
          dockerfile: cloudflare-ddns/Dockerfile
      
      - name: Lint shell scripts
        run: |
          sudo apt-get install shellcheck
          shellcheck cloudflare-ddns/run.sh

  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate config schema
        run: |
          # Add schema validation here
          echo "Config validation would go here"
```

To enable automated builds, see:
- https://developers.home-assistant.io/docs/add-ons/repository/
- https://github.com/home-assistant/builder
