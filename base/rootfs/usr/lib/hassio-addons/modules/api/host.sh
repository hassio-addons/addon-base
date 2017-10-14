#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: Host
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# List all available information about the host system
#
# Arguments:
#   $1 jq Filter to apply on the result (optional)
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.host.info() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /host/info false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns the type of the host
#
# Arguments:
#   None
# Returns:
#   Type of host
# ------------------------------------------------------------------------------
hass.api.host.info.type() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".type"
}

# ------------------------------------------------------------------------------
# Returns the version of the software running on the host
#
# Arguments:
#   None
# Returns:
#   Version
# ------------------------------------------------------------------------------
hass.api.host.info.version() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".version"
}

# ------------------------------------------------------------------------------
# Returns the latest version of the software for the host
#
# Arguments:
#   None
# Returns:
#   Latest version
# ------------------------------------------------------------------------------
hass.api.host.info.last_version() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".last_version"
}

# ------------------------------------------------------------------------------
# Returns a list of exposed features by the host
#
# Arguments:
#   None
# Returns:
#   List of features
# ------------------------------------------------------------------------------
hass.api.host.info.features() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".features[]"
}

# ------------------------------------------------------------------------------
# Returns the hostname of the host system
#
# Arguments:
#   None
# Returns:
#   Hostname
# ------------------------------------------------------------------------------
hass.api.host.info.hostname() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".hostname"
}

# ------------------------------------------------------------------------------
# Returns the OS of the host system
#
# Arguments:
#   None
# Returns:
#   OS
# ------------------------------------------------------------------------------
hass.api.host.info.os() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".os"
}

# ------------------------------------------------------------------------------
# Returns a list of available hardware on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object with hardware
# ------------------------------------------------------------------------------
hass.api.host.hardware() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /host/hardware false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns a list of available serial devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.host.hardware.serial() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.hardware ".serial[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available input devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.host.hardware.input() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.hardware ".input[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available disk devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.host.hardware.disk() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.hardware ".disk[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available audio devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.host.hardware.audio() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.hardware ".audio[]"
}

# ------------------------------------------------------------------------------
# Reboots the host system
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.host.reboot() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /host/reboot
}

# ------------------------------------------------------------------------------
# Shuts down the host system
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.host.shutdown() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /host/shutdown
}

# ------------------------------------------------------------------------------
# Updates the host system to the latest version
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.host.update() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /host/update
}
