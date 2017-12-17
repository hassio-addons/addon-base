#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Base Images
# Checks version requirements for this add-on
# ==============================================================================
# shellcheck source=base/rootfs/usr/lib/hassio-addons/base.sh
source /usr/lib/hassio-addons/base.sh

declare version

if hass.api.supervisor.ping; then

    if [[ ! -z "${SUPERVISOR_VERSION:-}" ]]; then
        version=$(hass.api.supervisor.info.version)
        hass.log.debug "Current Supervisor version: ${version}"
        hass.log.debug "Supervisor version condition: ${SUPERVISOR_VERSION}"

        if semver -q "${SUPERVISOR_VERSION}" "${version}"; then
            hass.log.info "Supervisor version requirements checks passed."
        else
            hass.log.fatal "You Supervisor version is: ${version}"
            hass.log.fatal "This add-on requires: ${SUPERVISOR_VERSION}"
            hass.die 'Please consider upgrading.'
        fi
    fi

    if [[ ! -z "${HOME_ASSISTANT_VERSION:-}" ]]; then
        version=$(hass.api.homeassistant.info.version)
        hass.log.debug "Current Home Assistant version: ${version}"
        hass.log.debug "Home Assistant version condition: ${HOME_ASSISTANT_VERSION}"

        if semver -q "${HOME_ASSISTANT_VERSION}" "${version}"; then
            hass.log.info "Home Assistant version requirements checks passed."
        else
            hass.log.fatal "You Home Assistant version is: ${version}"
            hass.log.fatal "This add-on requires: ${HOME_ASSISTANT_VERSION}"
            hass.die 'Please consider upgrading.'
        fi
    fi

else
    hass.log.warning 'Could not check version requirements!'
    hass.log.warning 'Continue startup process... (might fail)'
fi