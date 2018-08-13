#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Base Images
# Displays a simple add-on banner on startup
# ==============================================================================
# shellcheck source=base/rootfs/usr/lib/hassio-addons/base.sh
source /usr/lib/hassio-addons/base.sh

if hass.api.supervisor.ping; then
    echo '-----------------------------------------------------------'
    echo " Hass.io Add-on: $(hass.addon.name) v$(hass.addon.version)"
    echo ''
    echo " $(hass.addon.description)"
    echo ''
    echo " From: $(hass.addon.repository)"
    echo " By: $(hass.addon.maintainer)"
    echo '-----------------------------------------------------------'
    echo -n " $(hass.api.supervisor.info.arch)" && \
    echo -n " / $(hass.api.host.info.operating_system)" && \
    echo -n " / HA $(hass.api.homeassistant.info.version)" && \
    echo -n " / SU $(hass.api.supervisor.info.version)"
    echo " / $(hass.api.supervisor.info.channel)"
    echo '-----------------------------------------------------------'
fi
