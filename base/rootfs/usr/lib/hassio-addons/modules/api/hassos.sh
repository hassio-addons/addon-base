#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: HassOS
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# List all available information about the HassOS host system
#
# Arguments:
#   None
# Returns:
#   JSON object with HassOS information
# ------------------------------------------------------------------------------
hass.api.hassos.info() {
    local filter=${1:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /hassos/info false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns the version of HassOS
#
# Arguments:
#   None
# Returns:
#   Version
# ------------------------------------------------------------------------------
hass.api.hassos.info.version() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hassos.info ".version"
}

# ------------------------------------------------------------------------------
# Returns the CLI version of HassOS
#
# Arguments:
#   None
# Returns:
#   CLI version
# ------------------------------------------------------------------------------
hass.api.hassos.info.version_cli() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hassos.info ".version_cli"
}

# ------------------------------------------------------------------------------
# Returns the latest version of HassOS
#
# Arguments:
#   None
# Returns:
#   Latest version
# ------------------------------------------------------------------------------
hass.api.hassos.info.version_latest() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hassos.info ".version_latest"
}

# ------------------------------------------------------------------------------
# Returns the latest CLI version of HassOS
#
# Arguments:
#   None
# Returns:
#   Latest CLI version
# ------------------------------------------------------------------------------
hass.api.hassos.info.version_cli_latest() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hassos.info ".version_cli_latest"
}

# ------------------------------------------------------------------------------
# Returns the board running HassOS
#
# Arguments:
#   None
# Returns:
#   The board
# ------------------------------------------------------------------------------
hass.api.hassos.info.board() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.hassos.info ".board"
}

# ------------------------------------------------------------------------------
# Updates HassOS to the latest version
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.hassos.update() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /hassos/update
}

# ------------------------------------------------------------------------------
# Updates HassOS CLI to the latest version
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.hassos.update.cli() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /hassos/update/cli
}

# ------------------------------------------------------------------------------
# Load HassOS host configuration from USB stick
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.hassos.config.sync() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /hassos/config/sync
}
