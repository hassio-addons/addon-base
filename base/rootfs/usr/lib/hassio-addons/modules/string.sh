#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides string manupulation functions
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Converts a string to upper case
#
# Arguments:
#   $1 String to convert
# Returns:
#   Uppercase string
# ------------------------------------------------------------------------------
hass.string.upper() {
    local string="${1}"
    hass.log.trace "${FUNCNAME[0]}:" "$@"
    echo "${string^^}"
}

# ------------------------------------------------------------------------------
# Converts a string to lower case
#
# Arguments:
#   $1 String to convert
# Returns:
#   Lowercase string
# ------------------------------------------------------------------------------
hass.string.lower() {
    local string="${1}"
    hass.log.trace "${FUNCNAME[0]}:" "$@"
    echo "${string,,}"
}

# ------------------------------------------------------------------------------
# Returns the length of a string
#
# Arguments:
#   $1 String to determine the length of
# Returns:
#   Length of the string
# ------------------------------------------------------------------------------
hass.string.length() {
    local string="${1}"
    hass.log.trace "${FUNCNAME[0]}:" "$@"
    echo "${#string}"
}

# ------------------------------------------------------------------------------
# Replaces parts of the string with an other string
#
# Arguments:
#   $1 String to make replacements in
#   $2 String part to replace
#   $3 String replacement
# Returns:
#   The resulting string
# ------------------------------------------------------------------------------
hass.string.replace() {
    local string="${1}"
    local needle="${2}"
    local replacement="${3}"
    hass.log.trace "${FUNCNAME[0]}:" "$@"
    echo "${string//${needle}/${replacement}}"
}

# ------------------------------------------------------------------------------
# Returns a substring of a string
#
# stringZ=abcABC123ABCabc
# hass.string.substring "${stringZ}" 0      # abcABC123ABCabc
# hass.string.substring "${stringZ}" 1      # bcABC123ABCabc
# hass.string.substring "${stringZ}" 7      # 23ABCabc
# hass.string.substring "${stringZ}" 7 3    # 23AB
#
# Arguments:
#   $1 String to return a substring off
#   $2 Position to start
#   $3 Length of the substring (optional)
# Returns:
#   The resulting string
# ------------------------------------------------------------------------------
hass.string.substring() {
    local string="${1}"
    local position="${2}"
    local length="${3:-}"
    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if hass.has_value "${length}"; then
        echo "${string:${position}:${length}}"
    else
        echo "${string:${position}}"
    fi
}
