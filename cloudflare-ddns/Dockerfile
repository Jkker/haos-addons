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

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Set working directory
WORKDIR /

# Run script
CMD ["/run.sh"]
