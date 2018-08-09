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
declare -A CACHE

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# Checks if a given password is safe to use
#
# Arguments:
#   $1 The password to check
# Returns:
#   None
# ------------------------------------------------------------------------------
function hass.pwned.is_safe_password () {
    local password="${1}"
    local occurances

    hass.log.trace "${FUNCNAME[0]}" "<REDACTED PASSWORD>"

    if ! occurances=$(hass.pwned.call "${password}"); then
        hass.log.warning "Could not check password, assuming it is safe."
        return "${EX_OK}"
    fi

    if [[ "${occurances}" -ne 0 ]]; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Gets the number of occurances of the password in the list.
#
# Arguments:
#   $1 The password to check
# Returns:
#   Number of occurance.
# ------------------------------------------------------------------------------
function hass.pwned.occurances() {
    local password="${1}"
    local occurances

    hass.log.trace "${FUNCNAME[0]}" "<REDACTED PASSWORD>"

    if ! occurances=$(hass.pwned.call "${password}"); then
        occurances="0"
    fi

    echo "${occurances}"
    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Makes a call to the Have I Been Pwned password database
#
# Arguments:
#   $1 The password to check
# Returns:
#   Number of occurances
# ------------------------------------------------------------------------------
function hass.pwned.call() {
    local password="${1}"
    local response
    local status
    local hibp_hash
    local count

    hass.log.trace "${FUNCNAME[0]}" "${password//./x}"

    # Has the password
    password=$(echo -n "${password}" \
        | sha1sum \
        | tr '[:lower:]' '[:upper:]' \
        | awk -F' ' '{ print $1 }'
    )
    hass.log.debug "Password SHA1: ${password}"

    # Check if response is cached
    if [[ "${CACHE[${password}]+isset}" ]]; then
        echo "${CACHE[${password}]}"
        return "${EX_OK}"
    fi

    # Check with have I Been Powned, only send the first 5 chars of the hash
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
    hass.log.trace "API Response: ${response}"

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

    # Check the list of returned hashes for a match
    for hibp_hash in ${response}; do
        if [[ "${password:5:35}" == "${hibp_hash%%:*}" ]]; then
            # Found a match! This is bad :(
            count=$(echo "${hibp_hash#*:}" | tr -d '\r')

            hass.log.warning \
                "Password is in the Have I Been Pwned database!"
            hass.log.warning \
                "Password appeared ${count} times!"
            echo "${count}"

            # Store response in case it is asked again
            CACHE[${password}]="${count}"

            # Well, at least the execution of this function succeeded.
            return "${EX_OK}"
        fi
    done

    # Password was not found
    echo "0"
    CACHE[${password}]="0"
    hass.log.info "Password is NOT in the Have I Been Pwned database! Nice!"

    return "${EX_OK}"
}
