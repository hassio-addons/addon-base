#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Base Images
# Sets the log level correctly
# ==============================================================================
# shellcheck source=base/rootfs/lib/hassio-addons/base.sh
source /lib/hassio-addons/base.sh

declare log_level

# Check if the log level configuration option exists
if hass.config.exists "log_level"; then

    # Find the matching LOG_LEVEL
    case "$(hass.string.lower $(hass.config.get "log_level"))" in
        all)
            log_level="${LOG_LEVEL_ALL}"
            ;;
        trace)
            log_level="${LOG_LEVEL_TRACE}"
            ;;
        debug)
            log_level="${LOG_LEVEL_DEBUG}"
            ;;
        info)
            log_level="${LOG_LEVEL_INFO}"
            ;;
        notice)
            log_level="${LOG_LEVEL_NOTICE}"
            ;;
        warning)
            log_level="${LOG_LEVEL_WARNING}"
            ;;
        error)
            log_level="${LOG_LEVEL_ERROR}"
            ;;
        fatal)
            log_level="${LOG_LEVEL_FATAL}"
            ;;
        off)
            log_level="${LOG_LEVEL_OFF}"
            ;;
        *)
            hass.die "Unknown log_level: ${log_level}"
    esac

    # Save determined log level so S6 can pick it up later
    echo "${log_level}" > /var/run/s6/container_environment/LOG_LEVEL
    echo "Log level is set to ${LOG_LEVELS[$log_level]}"
fi
