#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: Network
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# List all available information about the network
#
# Arguments:
#   $1 jq Filter to apply on the result (optional)
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.network.info() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /network/info false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns the hostname
#
# Arguments:
#   None
# Returns:
#   Hostname
# ------------------------------------------------------------------------------
hass.api.network.info.hostname() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".hostname"
}
