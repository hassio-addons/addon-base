#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Base Images
# Displays a notice when there is an update available for this add-on
# ==============================================================================
# shellcheck source=base/rootfs/usr/lib/hassio-addons/base.sh
source /usr/lib/hassio-addons/base.sh

if hass.api.supervisor.ping; then
    if hass.addon.update_available; then
        hass.log.warning 'There is an update available for this add-on!'
        hass.log.notice "Current installed version: $(hass.addon.version)"
        hass.log.notice "Latest version: $(hass.addon.last_version)"
        hass.log.info 'Please consider updating this add-on.'
    else
        hass.log.info 'You are running the latest version of this add-on'
    fi
fi