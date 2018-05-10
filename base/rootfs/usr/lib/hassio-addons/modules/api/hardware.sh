#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: Hardware
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Returns a list of available hardware on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object with hardware
# ------------------------------------------------------------------------------
hass.api.hardware.info() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /hardware/info false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns a list of available serial devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.hardware.info.serial() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hardware.info ".serial[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available input devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.hardware.info.input() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hardware.info ".input[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available disk devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.hardware.info.disk() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hardware.info ".disk[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available disk devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.hardware.info.gpio() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hardware.info ".gpio[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available audio hardware devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.hardware.info.audio() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hardware.info ".audio[]"
}

# ------------------------------------------------------------------------------
# Returns a list of available audio devices on the host system
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.hardware.audio() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET /hardware/audio false ".audio[]"
}
