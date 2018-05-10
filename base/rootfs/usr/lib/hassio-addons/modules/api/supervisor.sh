#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: Supervisor
# ==============================================================================

# ------------------------------------------------------------------------------
# Check to see if the Supervisor is still alive
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.supervisor.ping() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET /supervisor/ping
}

# ------------------------------------------------------------------------------
# List all available information about the Supervisor
#
# Arguments:
#   $1 jq Filter to apply on the result (optional)
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.supervisor.info() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /supervisor/info false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns the version of the Supervisor
#
# Arguments:
#   None
# Returns:
#   Version
# ------------------------------------------------------------------------------
hass.api.supervisor.info.version() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".version"
}

# ------------------------------------------------------------------------------
# Returns the latest version of the Supervisor
#
# Arguments:
#   None
# Returns:
#   Latest version
# ------------------------------------------------------------------------------
hass.api.supervisor.info.last_version() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".last_version"
}

# ------------------------------------------------------------------------------
# Returns whether or not the Supervisor is on the beta channel
#
# Arguments:
#   None
# Returns:
#   Whether or not the Supervisor is on the beta channel
# ------------------------------------------------------------------------------
hass.api.supervisor.info.beta_channel() { 
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".beta_channel // false"
}

# ------------------------------------------------------------------------------
# Returns the architecture of the system
#
# Arguments:
#   None
# Returns:
#   Architecture
# ------------------------------------------------------------------------------
hass.api.supervisor.info.arch() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".arch"
}

# ------------------------------------------------------------------------------
# Returns the current timezone of the system
#
# Arguments:
#   None
# Returns:
#   Architecture
# ------------------------------------------------------------------------------
hass.api.supervisor.info.timezone() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".timezone"
}

# ------------------------------------------------------------------------------
# Returns the time to wait after boot in seconds
#
# Arguments:
#   None
# Returns:
#   Second to wait for boot
# ------------------------------------------------------------------------------
hass.api.supervisor.info.wait_boot() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".wait_boot"
}

# ------------------------------------------------------------------------------
# Returns a list of all current installed add-ons
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.supervisor.info.addons() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".addons[]"
}

# ------------------------------------------------------------------------------
# Returns a list of all activated repositories
#
# Arguments:
#   None
# Returns:
#   List of URL's
# ------------------------------------------------------------------------------
hass.api.supervisor.info.addons_repositories() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.info ".addons_repositories[]"
}

# ------------------------------------------------------------------------------
# Updates the Supervisor to the latest version
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.supervisor.update() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /supervisor/update
}

# ------------------------------------------------------------------------------
# Reloads the Supervisor
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.supervisor.reload() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /supervisor/reload
}

# ------------------------------------------------------------------------------
# Returns the logs created by the Supervisor
#
# Arguments:
#   None
# Returns:
#   The logs in text format
# ------------------------------------------------------------------------------
hass.api.supervisor.logs() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET /supervisor/logs true
}

# ------------------------------------------------------------------------------
# List all available stats about the Supervisor
#
# Arguments:
#   $1 jq Filter to apply on the result (optional)
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.supervisor.stats() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /supervisor/stats false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns CPU usage from the Supervisor
#
# Arguments:
#   None
# Returns:
#   Usage in percent
# ------------------------------------------------------------------------------
hass.api.supervisor.stats.cpu_percent() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.stats ".cpu_percent"
}

# ------------------------------------------------------------------------------
# Returns memory usage from the Supervisor
#
# Arguments:
#   None
# Returns:
#   Usage in Mb
# ------------------------------------------------------------------------------
hass.api.supervisor.stats.memory_usage() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.stats ".memory_usage"    
}

# ------------------------------------------------------------------------------
# Returns memory limit from the Supervisor
#
# Arguments:
#   None
# Returns:
#   Usage in Mb
# ------------------------------------------------------------------------------
hass.api.supervisor.stats.memory_limit() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.stats ".memory_limit"    
}

# ------------------------------------------------------------------------------
# Returns outgoing network usage from the Supervisor
#
# Arguments:
#   None
# Returns:
#   Usage in Mb
# ------------------------------------------------------------------------------
hass.api.supervisor.stats.network_tx() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.stats ".network_tx"    
}

# ------------------------------------------------------------------------------
# Returns incoming network usage from the Supervisor
#
# Arguments:
#   None
# Returns:
#   Usage in Bytes
# ------------------------------------------------------------------------------
hass.api.supervisor.stats.network_rx() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.stats ".network_rx"    
}

# ------------------------------------------------------------------------------
# Returns disk read usage from the Supervisor
#
# Arguments:
#   None
# Returns:
#   Usage in Blocks
# ------------------------------------------------------------------------------
hass.api.supervisor.stats.blk_read() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.stats ".blk_read"    
}

# ------------------------------------------------------------------------------
# Returns disk write usage from the Supervisor
#
# Arguments:
#   None
# Returns:
#   Usage in Blocks
# ------------------------------------------------------------------------------
hass.api.supervisor.stats.blk_write() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.supervisor.stats ".blk_write"    
}
