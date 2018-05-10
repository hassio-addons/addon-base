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
# Currently only support full, passwordless snapshotting.
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
# Returns the slug of a snapshot
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   Name
# ------------------------------------------------------------------------------
hass.api.snapshots.info.slug() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.snapshots.info "${snapshot}" ".slug"
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
# Returns the size of a snapshot
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   Size in Mb
# ------------------------------------------------------------------------------
hass.api.snapshots.info.size() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.snapshots.info "${snapshot}" ".size"
}

# ------------------------------------------------------------------------------
# Returns if the snapshot is protected
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   True if it is protected, false otherwise.
# ------------------------------------------------------------------------------
hass.api.snapshots.info.size() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.snapshots.info "${snapshot}" ".protected // false"
}

# ------------------------------------------------------------------------------
# Returns the Home Assistant version installed when this snapshot was created.
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   Version
# ------------------------------------------------------------------------------
hass.api.snapshots.info.homeassistant() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.snapshots.info "${snapshot}" ".homeassistant"
}

# ------------------------------------------------------------------------------
# Returns a list of installed addons when this snapshot was created
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   JSON Object
# ------------------------------------------------------------------------------
hass.api.snapshots.info.addons() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.supervisor.info ".addons[]"
}

# ------------------------------------------------------------------------------
# Returns a list of installed add-on repositories when this snapshot was created
#
# Arguments:
#   $1 Snapshot slug
# Returns:
#   List of URL's
# ------------------------------------------------------------------------------
hass.api.snapshots.info.repositories() {
    local snapshot=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.supervisor.info ".repositories[]"
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
# Restores a full snapshot.
#
# Currently only support full, passwordless restore.
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
