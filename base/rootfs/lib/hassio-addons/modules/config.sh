#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides functions for reading the add-on configuration
# ==============================================================================

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly ADDON_CONFIG_PATH=/data/options.json

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Fetches a configuration value from the add-on config file
#
# Arguments:
#   $1 Key of the config option
# Returns:
#   Value of the key in the configuration file
# ------------------------------------------------------------------------------
hass.config.get() {
    local key=${1}
    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if ! hass.config.exists "${key}"; then
        return "${EX_OK}"
    fi

    if hass.jq.is_string "${ADDON_CONFIG_PATH}" ".${key}"; then
        hass.jq "${ADDON_CONFIG_PATH}" ".${key} // empty"
        return "${EX_OK}"
    fi

    if hass.jq.is_boolean "${ADDON_CONFIG_PATH}" ".${key}"; then
        hass.jq "${ADDON_CONFIG_PATH}" ".${key} // false"
        return "${EX_OK}"
    fi

    if hass.jq.is_array "${ADDON_CONFIG_PATH}" ".${key}"; then
        if hass.jq.has_value "${ADDON_CONFIG_PATH}" ".${key}"; then
            hass.jq "${ADDON_CONFIG_PATH}" ".${key}[]"
        fi
        return "${EX_OK}"
    fi

    if hass.jq.is_object "${ADDON_CONFIG_PATH}" ".${key}"; then
        if hass.jq.has_value "${ADDON_CONFIG_PATH}" ".${key}"; then
            hass.jq "${ADDON_CONFIG_PATH}" ".${key}{}"
        fi
        return "${EX_OK}"
    fi
    
    if hass.jq.is_number "${ADDON_CONFIG_PATH}" ".${key}"; then
        hass.jq "${ADDON_CONFIG_PATH}" ".${key}"
        return "${EX_OK}"
    fi
    
    return "${EX_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if a configuration option exists in the config file
#
# Arguments:
#   $1 Key of the config option
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.config.exists() {
    local key=${1}
    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if ! hass.jq.exists "${ADDON_CONFIG_PATH}" ".${key}"; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Checks if a configuration option has an actual value
#
# Arguments:
#   $1 Key of the config option
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.config.has_value() {
    local key=${1}
    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if ! hass.jq.has_value "${ADDON_CONFIG_PATH}" ".${key}"; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Checks if a configuration option is true
#
# Arguments:
#   $1 Key of the config option
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.config.true() {
    local key=${1}
    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if ! hass.jq.is_boolean "${ADDON_CONFIG_PATH}" ".${key}"; then
        return "${EX_NOK}"
    fi

    if [[ $(hass.config.get "${key}") = "true" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if a configuration option is false
#
# Arguments:
#   $1 Key of the config option
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.config.false() {
    local key=${1}
    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if ! hass.jq.is_boolean "${ADDON_CONFIG_PATH}" ".${key}"; then
        return "${EX_NOK}"
    fi

    if [[ $(hass.config.get "${key}") = "false" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"
}
