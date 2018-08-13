#!/bin/bash
# ==============================================================================
# Community Hass.io Add-ons: Base Images
# Displays an message right before terminating in case something went wrong
# ==============================================================================
# shellcheck source=base/rootfs/usr/lib/hassio-addons/base.sh
source /usr/lib/hassio-addons/base.sh

declare HASSIO_TOKEN

if [[ "${S6_STAGE2_EXITED}" -ne 0 ]]; then

    if hass.api.supervisor.ping; then
        # shellcheck disable=SC2034
        HASSIO_TOKEN=$(</var/run/s6/container_environment/HASSIO_TOKEN)
        echo '-----------------------------------------------------------'
        echo -n " v$(hass.addon.version)" && \
        echo -n " / $(hass.api.supervisor.info.arch)" && \
        echo -n " / $(hass.api.host.info.operating_system)" && \
        echo -n " / HA $(hass.api.homeassistant.info.version)" && \
        echo -n " / SU $(hass.api.supervisor.info.version)"
        echo " / $(hass.api.supervisor.info.channel)"
    fi

    echo '-----------------------------------------------------------'
    echo '                Oops! Something went wrong.'
    echo ' '
    echo ' We are so sorry, but something went terribly wrong when'
    echo ' starting or running this add-on.'
    echo ' '
    echo ' Be sure to check the log above, line by line, for hints.'
    echo '-----------------------------------------------------------'
fi
