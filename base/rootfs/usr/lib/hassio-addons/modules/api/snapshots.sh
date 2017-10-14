#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: Snapshots
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# List all available snapshots
#
# Arguments:
#   None
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.snapshots.list() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET /snapshots false ".snapshots[]"
}

# ------------------------------------------------------------------------------
# Reload the lists of available snapshots
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.snapshots.reload() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /snapshots/reload
}

# ------------------------------------------------------------------------------
# Create a new full snapshot
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.snapshots.new.full() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /snapshots/new/full
}

# ------------------------------------------------------------------------------
# Create a new partial snapshot
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.snapshots.new.partial() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /snapshots/new/partial
}

# ------------------------------------------------------------------------------
# List all available information about a snapshot
#
# Arguments:
#   $1 Slug of the snapshot to get detailed information for
#   $1 jq Filter to apply on the result (optional)
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.snapshots.info() {
    local snapshot=${1}
    local filter=${2:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET "/snapshots/${snapshot}/info" false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns the name of a snapshot
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   Name
# ------------------------------------------------------------------------------
hass.api.snapshots.info.name() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.snapshots.info "${snapshot}" ".name"
}

# ------------------------------------------------------------------------------
# Returns the date of a snapshot
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   Date
# ------------------------------------------------------------------------------
hass.api.snapshots.info.date() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.snapshots.info "${snapshot}" ".date"
}

# ------------------------------------------------------------------------------
# Removes a snapshot
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.snapshots.remove() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/snapshots/${snapshot}/remove"
}

# ------------------------------------------------------------------------------
# Restores a full snapshot
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.snapshots.restore.full() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/snapshots/${snapshot}/restore/full"
}

# ------------------------------------------------------------------------------
# Restores a partial snapshot
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.snapshots.restore.partial() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/snapshots/${snapshot}/restore/partial"
}
