ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install bashio for option parsing
RUN apk add --no-cache \
    bash \
    jq \
    curl

# Copy the cloudflare-ddns binary from the official image
COPY --from=favonia/cloudflare-ddns:latest /bin/ddns /usr/local/bin/ddns

# Copy root filesystem
COPY rootfs /

# Copy run script and set permissions
COPY run.sh /
RUN chmod a+x /run.sh && \
    chmod a+x /etc/services.d/cloudflare-ddns/run && \
    chmod a+x /etc/services.d/cloudflare-ddns/finish && \
    chmod a+x /init 2>/dev/null || true
