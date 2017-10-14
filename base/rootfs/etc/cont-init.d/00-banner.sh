#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Base Images
# Displays a simple add-on banner on startup
# ==============================================================================
# shellcheck source=base/rootfs/lib/hassio-addons/base.sh
source /lib/hassio-addons/base.sh

if hass.api.supervisor.ping; then
    echo '-----------------------------------------------------------'
    echo " Hass.io Add-on: $(hass.addon.name) v$(hass.addon.version)"
    echo ''
    echo " $(hass.addon.description)"
    echo ''
    echo " From: $(hass.addon.repository)"
    echo " By: $(hass.addon.maintainer)"
    echo '-----------------------------------------------------------'
fi