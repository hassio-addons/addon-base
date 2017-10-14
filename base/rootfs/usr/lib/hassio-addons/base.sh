#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# This is an bash function library for Hass.io add-ons.
# It contains a set of commonly used operations and can be used
# to be included in add-on scripts to reduce code duplication across add-ons.
# ==============================================================================
set -o errexit  # Exit script when a command exits with non-zero status
set -o errtrace # Exit on error inside any functions or sub-shells
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly EX_OK=0    # Successful termination
readonly EX_NOK=1   # Termination with errors

# Stores the location of this library
readonly __LIB_DIR=$(dirname "${BASH_SOURCE[0]}")

# ==============================================================================
# MODULES
# ==============================================================================
#shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/addon.sh
source "${__LIB_DIR}/modules/addon.sh"
#shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/api.sh
source "${__LIB_DIR}/modules/api.sh"
#shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/config.sh
source "${__LIB_DIR}/modules/config.sh"
#shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/jq.sh
source "${__LIB_DIR}/modules/jq.sh"
#shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/log.sh
source "${__LIB_DIR}/modules/log.sh"
#shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/string.sh
source "${__LIB_DIR}/modules/string.sh"

# ==============================================================================
# MISC FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Exit the script with an optional error messge
#
# Arguments:
#   $1 Error message (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.die() {
    local message=${1:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if hass.has_value "${message}"; then
        hass.log.fatal "${message}"
    fi

    exit "${EX_NOK}"
}

# ------------------------------------------------------------------------------
# Exit the script when given value is false, with an optional error messge
#
# Arguments:
#   $1 Value to check if false
#   $2 Error message (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.die_if_false() {
    local value=${1:-}
    local message=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if hass.false "${value}"; then
        hass.die "${message}"
    fi
}

# ------------------------------------------------------------------------------
# Exit the script when given value is true, with an optional error messge
#
# Arguments:
#   $1 Value to check if true
#   $2 Error message (optional)
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.die_if_true() {
    local value=${1:-}
    local message=${2:-}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if hass.true "${value}"; then
        hass.die "${message}"
    fi
}

# ------------------------------------------------------------------------------
# Check whether or not a directory exists
#
# Arguments:
#   $1 Path to directory
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.directory_exists() {
    local directory=${1}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -d "${directory}" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"
}

# ------------------------------------------------------------------------------
# Check whether or not a file exists
#
# Arguments:
#   $1 Path to file
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.file_exists() {
    local file=${1}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -f "${file}" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"    
}

# ------------------------------------------------------------------------------
# Check whether or not a device exists
#
# Arguments:
#   $1 Path to device
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.device_exists() {
    local device=${1}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -d "${device}" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"        
}

# ------------------------------------------------------------------------------
# Checks if a give value is true
#
# Arguments:
#   $1 value
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.true() {
    local value=${1:-null}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if [[ "${value}" = "true" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if a give value is false
#
# Arguments:
#   $1 value
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.false() {
    local value=${1:-null}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if [[ "${value}" = "false" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"
}

# ------------------------------------------------------------------------------
# Runs a command, while supressing all output
#
# Arguments:
#   $1 command
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.quietly() {
    local command=$*

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    ${command} > /dev/null 2>&1
}

# ------------------------------------------------------------------------------
# Checks if a global variable is defined
#
# Arguments:
#   $1 Name of the variable
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.defined() {
    local variable=${1}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    [[ "${!variable-X}" = "${!variable-Y}" ]]
}

# ------------------------------------------------------------------------------
# Checks if a value has actual value
#
# Arguments:
#   $1 Value
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.has_value() {
    local value=${1}

    hass.log.trace "${FUNCNAME[0]}:" "$@"

    if [[ -n "${value}" ]]; then
        return "${EX_OK}"
    fi

    return "${EX_NOK}"
}

# ------------------------------------------------------------------------------
# Checks if we are currently running in debug mode, based on the log module
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.debug() {
    if [[ "${LOG_LEVEL_DEBUG}" -gt "${LOG_LEVEL}" ]]; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}
