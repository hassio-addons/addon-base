#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides basic functions for reading the current add-on configuration.
# For more advances options, use the hass.addons.* functions
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Returns the name of the current running add-on
#
# Arguments:
#   None
# Returns:
#   Name of the current Add-on running
# ------------------------------------------------------------------------------
hass.addon.name() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.addons.info.name "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Returns the slug of the current running add-on
#
# Arguments:
#   None
# Returns:
#   Slug of the current Add-on running
# ------------------------------------------------------------------------------
hass.addon.slug() {
    local hostname
    hass.log.trace "${FUNCNAME[0]}"
    hostname=$(hostname)
    echo "${hostname/-/_}"
}

# ------------------------------------------------------------------------------
# Returns the description of the current running add-on
#
# Arguments:
#   None
# Returns:
#   Description of the current Add-on running
# ------------------------------------------------------------------------------
hass.addon.description() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.addons.info.description "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Returns the name of the repository of the current running add-on
#
# Arguments:
#   None
# Returns:
#   Name of the repository
# ------------------------------------------------------------------------------
hass.addon.repository() {
    local slug
    hass.log.trace "${FUNCNAME[0]}"
    slug=$(hass.api.addons.info.repository "$(hass.addon.slug)")
    hass.api.addons.repositories.info.name "${slug}"
}

# ------------------------------------------------------------------------------
# Returns the maintainer of the current running add-on
#
# Arguments:
#   None
# Returns:
#   Maintainer of the current Add-on running
# ------------------------------------------------------------------------------
hass.addon.maintainer() {
    local slug
    hass.log.trace "${FUNCNAME[0]}"
    slug=$(hass.api.addons.info.repository "$(hass.addon.slug)")
    hass.api.addons.repositories.info.maintainer "${slug}"
}

# ------------------------------------------------------------------------------
# Returns the version of the current running add-on
#
# Arguments:
#   None
# Returns:
#   Version of the current Add-on running
# ------------------------------------------------------------------------------
hass.addon.version() {
    hass.api.addons.info.version "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Returns the latest version of the current running add-on
#
# Arguments:
#   None
# Returns:
#   Latest version of the current Add-on running
# ------------------------------------------------------------------------------
hass.addon.last_version() {
    hass.api.addons.info.last_version "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Restarts the current running add-on
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.addon.restart() {
    hass.api.addons.restart "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Stops the current running add-on
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.addon.stop() {
    hass.api.addons.stop "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Updates the current running add-on
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.addon.update() {
    hass.api.addons.update "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Rebuilds the current running add-on
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.addon.rebuild() {
    hass.api.addons.rebuild "$(hass.addon.slug)"
}

# ------------------------------------------------------------------------------
# Check if there is an update available for the running add-on
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.addon.update_available() {
    hass.api.addons.update_available "$(hass.addon.slug)"
}
