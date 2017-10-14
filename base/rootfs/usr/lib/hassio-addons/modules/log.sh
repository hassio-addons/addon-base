#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides functions for simple logging
# ==============================================================================

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly LOG_LEVEL_ALL=8
readonly LOG_LEVEL_DEBUG=6
readonly LOG_LEVEL_ERROR=2
readonly LOG_LEVEL_FATAL=1
readonly LOG_LEVEL_INFO=5
readonly LOG_LEVEL_NOTICE=4
readonly LOG_LEVEL_OFF=0
readonly LOG_LEVEL_TRACE=7
readonly LOG_LEVEL_WARNING=3
readonly -A LOG_LEVELS=(
    [${LOG_LEVEL_OFF}]="OFF"
    [${LOG_LEVEL_FATAL}]="FATAL"
    [${LOG_LEVEL_ERROR}]="ERROR"
    [${LOG_LEVEL_WARNING}]="WARNING"
    [${LOG_LEVEL_NOTICE}]="NOTICE"
    [${LOG_LEVEL_INFO}]="INFO"
    [${LOG_LEVEL_DEBUG}]="DEBUG"
    [${LOG_LEVEL_TRACE}]="TRACE"
    [${LOG_LEVEL_ALL}]="ALL"
)
readonly LOG_FORMAT_DEFAULT="[{TIMESTAMP}] {LEVEL} ----> {MESSAGE}"
readonly LOG_TIMESTAMP_DEFAULT="%T%z"

declare LOG_FORMAT=${LOG_FORMAT:-${LOG_FORMAT_DEFAULT}}
declare LOG_LEVEL=${LOG_LEVEL:-${LOG_LEVEL_INFO}}
declare LOG_TIMESTAMP_FORMAT=${LOG_TIMESTAMP_FORMAT:-${LOG_TIMESTAMP_DEFAULT}}

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Log a message
#
# Arguments:
#   $1 Log level
#   $2 Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.log() {
    local level=${1}
    local message=${2}
    local timestamp
    local output

    if [[ "${level}" -gt "${LOG_LEVEL}" ]]; then
        return "${EX_OK}"
    fi

    timestamp=$(date +"${LOG_TIMESTAMP_FORMAT}")

    output="${LOG_FORMAT}"
    output="${output//\{TIMESTAMP\}/${timestamp}}"
    output="${output//\{MESSAGE\}/${message}}"
    output="${output//\{LEVEL\}/${LOG_LEVELS[$level]}}"

    echo "${output}" >&2

    return "${EX_OK}"
}


# ------------------------------------------------------------------------------
# Log a message @ trace level
#
# Arguments:
#   $* Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.trace() {
    local message=$*
    hass.log.log "${LOG_LEVEL_TRACE}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ debug level
#
# Arguments:
#   $* Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.debug() {
    local message=$*
    hass.log.log "${LOG_LEVEL_DEBUG}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ info level
#
# Arguments:
#   $* Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.info() {
    local message=$*
    hass.log.log "${LOG_LEVEL_INFO}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ notice level
#
# Arguments:
#   $* Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.notice() {
    local message=$*
    hass.log.log "${LOG_LEVEL_NOTICE}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ warning level
#
# Arguments:
#   $* Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.warning() {
    local message=$*
    hass.log.log "${LOG_LEVEL_WARNING}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ error level
#
# Arguments:
#   $* Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.error() {
    local message=$*
    hass.log.log "${LOG_LEVEL_ERROR}" "${message}"
}

# ------------------------------------------------------------------------------
# Log a message @ fatal level
#
# Arguments:
#   $* Message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.log.fatal() {
    local message=$*
    hass.log.log "${LOG_LEVEL_FATAL}" "${message}"
}
