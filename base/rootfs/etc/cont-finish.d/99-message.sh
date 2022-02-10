#!/usr/bin/env bashio
# ==============================================================================
# Home Assistant Community Add-on: Base Images
# Displays an message right before terminating in case something went wrong
# ==============================================================================

# Capture exit code of the container
# See: https://github.com/just-containers/s6-overlay/issues/406#issuecomment-1034925976
if [[ -f "/run/s6-linux-init-container-results/exitcode" ]]; then
    exit_code=$(cat "/run/s6-linux-init-container-results/exitcode")
else
    exit_code=0
fi

if [[ "${exit_code}" -ne 0 ]]; then
    bashio::log.red \
        '-----------------------------------------------------------'
    bashio::log.red '                Oops! Something went wrong.'
    bashio::log.red
    bashio::log.red ' We are so sorry, but something went terribly wrong when'
    bashio::log.red ' starting or running this add-on.'
    bashio::log.red ' '
    bashio::log.red ' Be sure to check the log above, line by line, for hints.'
    bashio::log.red \
        '-----------------------------------------------------------'
fi
