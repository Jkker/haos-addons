#!/usr/bin/env bashio

# ==============================================================================
# Home Assistant Add-on: Cloudflare DDNS
# Configures and runs the Cloudflare DDNS updater
# ==============================================================================

bashio::log.info "Starting Cloudflare DDNS..."

# Required: Cloudflare API Token
if bashio::config.has_value 'cloudflare_api_token'; then
    export CLOUDFLARE_API_TOKEN=$(bashio::config 'cloudflare_api_token')
    bashio::log.info "Cloudflare API token configured"
else
    bashio::log.fatal "Cloudflare API token is required!"
    exit 1
fi

# Required: Domains (can be in domains, ip4_domains, or ip6_domains)
declare domains=""
declare ip4_domains=""
declare ip6_domains=""

if bashio::config.has_value 'domains'; then
    domains=$(bashio::config 'domains | join(",")')
    bashio::log.info "Managing domains: ${domains}"
fi

if bashio::config.has_value 'ip4_domains'; then
    ip4_domains=$(bashio::config 'ip4_domains | join(",")')
    bashio::log.info "Managing IPv4 domains: ${ip4_domains}"
fi

if bashio::config.has_value 'ip6_domains'; then
    ip6_domains=$(bashio::config 'ip6_domains | join(",")')
    bashio::log.info "Managing IPv6 domains: ${ip6_domains}"
fi

# Set domains environment variables
if [ -n "${domains}" ]; then
    export DOMAINS="${domains}"
fi
if [ -n "${ip4_domains}" ]; then
    export IP4_DOMAINS="${ip4_domains}"
fi
if [ -n "${ip6_domains}" ]; then
    export IP6_DOMAINS="${ip6_domains}"
fi

# Check that at least one domain is configured
if [ -z "${DOMAINS}" ] && [ -z "${IP4_DOMAINS}" ] && [ -z "${IP6_DOMAINS}" ]; then
    bashio::log.fatal "At least one domain must be configured in 'domains', 'ip4_domains', or 'ip6_domains'!"
    exit 1
fi

# Optional: Proxied
if bashio::config.has_value 'proxied'; then
    export PROXIED=$(bashio::config 'proxied')
    bashio::log.info "Cloudflare proxying: ${PROXIED}"
fi

# Optional: IP Providers
if bashio::config.has_value 'ip4_provider'; then
    export IP4_PROVIDER=$(bashio::config 'ip4_provider')
    bashio::log.info "IPv4 provider: ${IP4_PROVIDER}"
fi

if bashio::config.has_value 'ip6_provider'; then
    export IP6_PROVIDER=$(bashio::config 'ip6_provider')
    bashio::log.info "IPv6 provider: ${IP6_PROVIDER}"
fi

# Optional: Update Schedule
if bashio::config.has_value 'update_cron'; then
    export UPDATE_CRON=$(bashio::config 'update_cron')
    bashio::log.info "Update schedule: ${UPDATE_CRON}"
fi

if bashio::config.has_value 'update_on_start'; then
    export UPDATE_ON_START=$(bashio::config 'update_on_start')
fi

# Optional: Timezone
if bashio::config.has_value 'timezone'; then
    export TZ=$(bashio::config 'timezone')
    bashio::log.info "Timezone: ${TZ}"
fi

# Optional: TTL
if bashio::config.has_value 'ttl'; then
    export TTL=$(bashio::config 'ttl')
    bashio::log.info "DNS TTL: ${TTL}"
fi

# Optional: Record Comment
if bashio::config.has_value 'record_comment'; then
    export RECORD_COMMENT=$(bashio::config 'record_comment')
    bashio::log.info "Record comment: ${RECORD_COMMENT}"
fi

# Optional: Cache Expiration
if bashio::config.has_value 'cache_expiration'; then
    export CACHE_EXPIRATION=$(bashio::config 'cache_expiration')
fi

# Optional: Delete on Stop
if bashio::config.has_value 'delete_on_stop'; then
    export DELETE_ON_STOP=$(bashio::config 'delete_on_stop')
fi

# Optional: Timeouts
if bashio::config.has_value 'detection_timeout'; then
    export DETECTION_TIMEOUT=$(bashio::config 'detection_timeout')
fi

if bashio::config.has_value 'update_timeout'; then
    export UPDATE_TIMEOUT=$(bashio::config 'update_timeout')
fi

# Optional: Logging
if bashio::config.has_value 'emoji'; then
    export EMOJI=$(bashio::config 'emoji')
fi

if bashio::config.has_value 'quiet'; then
    export QUIET=$(bashio::config 'quiet')
fi

# Optional: Healthchecks
if bashio::config.has_value 'healthchecks_url'; then
    export HEALTHCHECKS=$(bashio::config 'healthchecks_url')
    bashio::log.info "Healthchecks monitoring enabled"
fi

# Optional: Uptime Kuma
if bashio::config.has_value 'uptimekuma_url'; then
    export UPTIMEKUMA=$(bashio::config 'uptimekuma_url')
    bashio::log.info "Uptime Kuma monitoring enabled"
fi

# Optional: Shoutrrr (notifications)
if bashio::config.has_value 'shoutrrr_urls'; then
    shoutrrr_urls=$(bashio::config 'shoutrrr_urls')
    if [ "${shoutrrr_urls}" != "[]" ] && [ -n "${shoutrrr_urls}" ]; then
        # Convert array to newline-separated string
        export SHOUTRRR=$(bashio::config 'shoutrrr_urls | join("\n")')
        bashio::log.info "Shoutrrr notifications enabled"
    fi
fi

# Optional: WAF Lists (experimental)
if bashio::config.has_value 'waf_lists'; then
    waf_lists=$(bashio::config 'waf_lists')
    if [ "${waf_lists}" != "[]" ] && [ -n "${waf_lists}" ]; then
        export WAF_LISTS=$(bashio::config 'waf_lists | join(",")')
        bashio::log.info "WAF lists management enabled (experimental)"
    fi
fi

bashio::log.info "Starting cloudflare-ddns updater..."

# Execute the cloudflare-ddns binary
exec /usr/local/bin/ddns
