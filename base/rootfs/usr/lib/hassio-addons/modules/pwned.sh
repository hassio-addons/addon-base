#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides interface with the password checks from HaveIBeenPwned.com
# ==============================================================================

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly HIBP_ENDPOINT='https://api.pwnedpasswords.com/range'

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Makes a call to the Have I Been Pwned password database
#
# Arguments:
#   $1 The password to check
# Returns:
#   Number of occurances.
# ------------------------------------------------------------------------------
function hass.pwned.password() {
    local password="${1}"
    local response
    local status
    local hibp_hash
    local count

    hass.log.trace "${FUNCNAME[0]}" "${password//./*}"

    password=$(echo -n "${password}" \
        | sha1sum \
        | tr '[:lower:]' '[:upper:]' \
        | awk -F' ' '{ print $1 }'
    )

    hass.log.debug "Password SHA1: ${password}"

    if ! response=$(curl \
        --silent \
        --show-error \
        --write-out '\n%{http_code}' \
        --request GET \
        "${HIBP_ENDPOINT}/${password:0:5}"
    ); then
        hass.log.debug "${response}"
        hass.log.error "Something went wrong contacting the HIBP API"
        return "${EX_NOK}"
    fi

    status=${response##*$'\n'}
    response=${response%$status}

    hass.log.debug "Requested API resource: ${HIBP_ENDPOINT}/${password:0:5}"
    hass.log.debug "API HTTP Response code: ${status}"
    hass.log.debug "API Response: ${response}"

    if [[ "${status}" -eq 429 ]]; then
        hass.log.error "HIBP Rate limit exceeded."
        return "${EX_NOK}"
    fi

    if [[ "${status}" -eq 503 ]]; then
        hass.log.error "HIBP Service unavailable."
        return "${EX_NOK}"
    fi

    if [[ "${status}" -ne 200 ]]; then
        hass.log.error "Unknown HIBP HTTP error occured."
        return "${EX_NOK}"
    fi

    for hibp_hash in ${response}; do
        if [[ "${password:5:35}" == "${hibp_hash%%:*}" ]]; then
            count=$(echo "${hibp_hash#*:}" | tr -d '\r')
            hass.log.warning \
                "Password is in the Have I Been Pwned database!"
            hass.log.warning \
                "Password appeared ${count} times!"
            echo "${count}"
            return "${EX_OK}"
        fi
    done

    hass.log.info "Password is NOT in the Have I Been Pwned database! Nice!"
    echo "0"
    return "${EX_OK}"
}
