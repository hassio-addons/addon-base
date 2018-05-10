#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io
# ==============================================================================

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly HASS_API_ENDPOINT='http://hassio'

# ==============================================================================
# MODULES
# ==============================================================================
# shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/api/addons.sh
source "${__LIB_DIR}/modules/api/addons.sh"
# shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/api/hardware.sh
source "${__LIB_DIR}/modules/api/hardware.sh"
# shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/api/homeassistant.sh
source "${__LIB_DIR}/modules/api/homeassistant.sh"
# shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/api/host.sh
source "${__LIB_DIR}/modules/api/host.sh"
# shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/api/snapshots.sh
source "${__LIB_DIR}/modules/api/snapshots.sh"
# shellcheck source=base/rootfs/usr/lib/hassio-addons/modules/api/supervisor.sh
source "${__LIB_DIR}/modules/api/supervisor.sh"

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Makes a call to the Hass.io API
#
# Arguments:
#   $1 HTTP Method (GET/POST)
#   $2 API Resource requested
#   $3 Whether or not this resource returns raw data instead of json (optional)
#   $4 jq filter command (optional)
# Returns:
#   Mixed content
# ------------------------------------------------------------------------------
hass.api.call() {
    local method=${1}
    local resource=${2}
    local raw=${3:-false}
    local filter=${4:-}
    local auth_header='X-HASSIO-KEY;'
    local response
    local status
    local result

    hass.log.trace "${FUNCNAME[0]}" "$@"

    if [[ ! -z "${HASSIO_TOKEN:-}" ]]; then
        auth_header="X-HASSIO-KEY: ${HASSIO_TOKEN}"
    fi

    if ! response=$(curl --silent --show-error \
        --write-out '\n%{http_code}' --request "${method}" \
        -H "${auth_header}" \
        "${HASS_API_ENDPOINT}${resource}"
    ); then
        hass.log.debug "${response}"
        hass.log.error "Something went wrong contacting the API"
        return "${EX_NOK}"
    fi

    status=${response##*$'\n'}
    response=${response%$status}

    hass.log.debug "Requested API resource: ${HASS_API_ENDPOINT}${resource}"
    hass.log.debug "API HTTP Response code: ${status}"
    hass.log.debug "API Response: ${response}" 
    
    if [[ "${status}" -eq 401 ]]; then
        hass.log.error "Unable to authenticate with the API, permission denied"
        return "${EX_NOK}"
    fi

    if [[ "${status}" -eq 404 ]]; then
        hass.log.error "Requested resource ${resource} was not found"
        return "${EX_NOK}"
    fi

    if [[ "${status}" -eq 405 ]]; then
        hass.log.error "Requested resource ${resource} was called using an" \
            "unallowed method."
        return "${EX_NOK}"
    fi

    if [[ $(hass.jq "${response}" ".result") = "error" ]]; then
        hass.log.error "Got unexpected response from the API:" \
            "$(hass.jq "${response}" '.message // empty')"
        return "${EX_NOK}"
    fi

    if [[ "${status}" -ne 200 ]]; then
        hass.log.error "Unknown HTTP error occured"
        return "${EX_NOK}"
    fi

    if [[ "${raw}" = "true" ]]; then
        echo "${response}"
        return "${EX_OK}"
    fi

    result=$(hass.jq "${response}" 'if .data == {} then empty else .data end')

    if hass.has_value "${filter}"; then
        hass.log.debug "Filtering response using: ${filter}"
        result=$(hass.jq "${result}" "${filter}")
    fi

    echo "${result}"
    return "${EX_OK}"
}
