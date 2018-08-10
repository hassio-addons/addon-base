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
# Returns the OS of the host system
#
# Arguments:
#   None
# Returns:
#   OS
# ------------------------------------------------------------------------------
hass.api.host.info.operating_system() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".operating_system"
}

# ------------------------------------------------------------------------------
# Returns the kernel of the host system
#
# Arguments:
#   None
# Returns:
#   OS
# ------------------------------------------------------------------------------
hass.api.host.info.kernel() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".kernel"
}

# ------------------------------------------------------------------------------
# Returns the chassis of the host system
#
# Arguments:
#   None
# Returns:
#   OS
# ------------------------------------------------------------------------------
hass.api.host.info.chassis() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".chassis"
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
# Returns the stability channel / deployment of the system
#
# Arguments:
#   None
# Returns:
#   Version
# ------------------------------------------------------------------------------
hass.api.host.info.deployment() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".deployment"
}

# ------------------------------------------------------------------------------
# Returns the cpe of the system
#
# Arguments:
#   None
# Returns:
#   Version
# ------------------------------------------------------------------------------
hass.api.host.info.deployment() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.host.info ".cpe"
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

# ------------------------------------------------------------------------------
# Reload the host controller
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.host.reload() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /host/reload
}

# ------------------------------------------------------------------------------
# Returns host services
#
# Arguments:
#   None
# Returns:
#   List of host services.
# ------------------------------------------------------------------------------
hass.api.host.services() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET /host/services false ".services[]"
}

# ------------------------------------------------------------------------------
# Stops a host service
#
# Arguments:
#   $1 unit name
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.host.service.stop() {
    local unit=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/host/service/${unit}/stop"
}

# ------------------------------------------------------------------------------
# Starts a host service
#
# Arguments:
#   $1 unit name
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.host.service.start() {
    local unit=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/host/service/${unit}/start"
}

# ------------------------------------------------------------------------------
# Reloads a host service
#
# Arguments:
#   $1 unit name
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.host.service.reload() {
    local unit=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/host/service/${unit}/reload"
}
