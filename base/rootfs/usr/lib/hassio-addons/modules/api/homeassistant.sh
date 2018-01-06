#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: Home Assistant
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# List all available information about the Home Assistant instance
#
# Arguments:
#   $1 jq Filter to apply on the result (optional)
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.homeassistant.info() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /homeassistant/info false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns the version of Home Assistant
#
# Arguments:
#   None
# Returns:
#   Version
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.version() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".version"
}

# ------------------------------------------------------------------------------
# Returns the latest version of Home Assistant
#
# Arguments:
#   None
# Returns:
#   Latest version
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.last_version() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".last_version"
}

# ------------------------------------------------------------------------------
# Returns the Docker image of Home Assistant
#
# Arguments:
#   None
# Returns:
#   Docker image
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.image() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".image"
}

# ------------------------------------------------------------------------------
# Returns whether or not a custom version of Home Assistant is installed
#
# Arguments:
#   None
# Returns:
#   Whether or not a custom Home Assistant is installed
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.custom() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".custom // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not Home Assistant starts at device boot
#
# Arguments:
#   None
# Returns:
#   Whether or not Home Assistant starts at boot
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.boot() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".boot // false"
}

# ------------------------------------------------------------------------------
# Returns the port number on which Home Assistant is running
#
# Arguments:
#   None
# Returns:
#   Port number
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.port() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".port"
}

# ------------------------------------------------------------------------------
# Returns whether or not Home Assistant is running on SSL
#
# Arguments:
#   None
# Returns:
#   Whether or not Home Assistant runs on SSL
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.ssl() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".ssl // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not Home Assistant is monitored by Watchdog
#
# Arguments:
#   None
# Returns:
#   Whether or not Home Assistant is monitored by Watchdog
# ------------------------------------------------------------------------------
hass.api.homeassistant.info.watchdog() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.homeassistant.info ".watchdog // false"
}

# ------------------------------------------------------------------------------
# Updates Home Assistant to the latest version
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.homeassistant.update() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /homeassistant/update
}

# ------------------------------------------------------------------------------
# Restarts Home Assistant
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.homeassistant.restart() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /homeassistant/restart
}

# ------------------------------------------------------------------------------
# Stops Home Assistant
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.homeassistant.stop() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /homeassistant/stop
}

# ------------------------------------------------------------------------------
# Starts Home Assistant
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.homeassistant.start() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /homeassistant/start
}

# ------------------------------------------------------------------------------
# Checks/validates your Home Assistant configuration
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.homeassistant.check() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /homeassistant/check
}

# ------------------------------------------------------------------------------
# Returns the logs created by Home Assistant
#
# Arguments:
#   None
# Returns:
#   The logs in text format
# ------------------------------------------------------------------------------
hass.api.homeassistant.logs() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET /homeassistant/logs true
}
