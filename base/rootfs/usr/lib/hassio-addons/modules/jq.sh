#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides helper function to the jq json query tool
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Execute a json query
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   jq result
# ------------------------------------------------------------------------------
hass.jq() {
    local data=${1}
    local filter=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"
    
    if [[ -f "${data}" ]]; then
        jq --raw-output "$filter" "${data}"
    else
        jq --raw-output "$filter" <<< "${data}"
    fi    
}

# ------------------------------------------------------------------------------
# Checks if variable exists (optionally after filtering)
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.exists() {
    local data=${1}
    local filter=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if [[ $(hass.jq "${data}" "${filter}") = "null" ]]; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Checks if data exists (optionally after filtering)
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.has_value() {
    local data=${1}
    local filter=${2:-}
    local value

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    value=$(hass.jq "${data}" \
        "${filter} | if (. == {} or . == []) then empty else . end // empty")
    
    if ! hass.has_value "${value}"; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Checks if resulting data is of a specific type
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter
#   $3 type (boolean, string, number, array, object, null)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.is() {
    local data=${1}
    local filter=${2}
    local type=${3}
    local value

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    value=$(hass.jq "${data}" \
        "${filter} | if type==\"${type}\" then true else false end")
    
    if [[ "${value}" = "false" ]]; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Checks if resulting data is a boolean
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.is_boolean() {
    local data=${1}
    local filter=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"
    hass.jq.is "${data}" "${filter}" "boolean"
}

# ------------------------------------------------------------------------------
# Checks if resulting data is a string
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.is_string() {
    local data=${1}
    local filter=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"
    hass.jq.is "${data}" "${filter}" "string"
}

# ------------------------------------------------------------------------------
# Checks if resulting data is an object
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.is_object() {
    local data=${1}
    local filter=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"
    hass.jq.is "${data}" "${filter}" "object"
}

# ------------------------------------------------------------------------------
# Checks if resulting data is a number
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.is_number() {
    local data=${1}
    local filter=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"
    hass.jq.is "${data}" "${filter}" "number"
}

# ------------------------------------------------------------------------------
# Checks if resulting data is an array
#
# Arguments:
#   $1 JSON string or path to a JSON file
#   $2 jq filter (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.jq.is_array() {
    local data=${1}
    local filter=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"
    hass.jq.is "${data}" "${filter}" "array"
}
