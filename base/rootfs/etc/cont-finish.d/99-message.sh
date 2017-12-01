#!/bin/bash
# ==============================================================================
# Community Hass.io Add-ons: Base Images
# Displays an message right before terminating in case something went wrong
# ==============================================================================

if [[ "${S6_STAGE2_EXITED}" -ne 0 ]]; then
    echo "Exit code: $(</var/run/s6/env-stage3/S6_STAGE2_EXITED)"
    echo '-----------------------------------------------------------'
    echo '                Oops! Something went wrong.'
    echo ' '
    echo ' We are so sorry, but something went terribly wrong when'
    echo ' starting or running this add-on.'
    echo ' '
    echo ' Be sure to check the log above, line by line, for hints.'
    echo '-----------------------------------------------------------'
fi
