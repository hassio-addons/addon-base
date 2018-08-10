#!/usr/bin/env bash
# ==============================================================================
# Community Hass.io Add-ons: Bash functions library
#
# Provides access to the API functions of Hass.io: Addons
# ==============================================================================

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# ------------------------------------------------------------------------------
# List all available Hass.io addons
#
# Arguments:
#   None
# Returns:
#   JSON addon objects
# ------------------------------------------------------------------------------
hass.api.addons.list() {
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET /addons false ".addons"
}

# ------------------------------------------------------------------------------
# List all installed Hass.io add-on repositories
#
# Arguments:
#   None
# Returns:
#   JSON repository objects
# ------------------------------------------------------------------------------
hass.api.addons.repositories() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET /addons false ".repositories"
}

# ------------------------------------------------------------------------------
# Gives all available information for a repository
#
# Arguments:
#   $1 Repository slug
#   $2 jq Filter to apply on the result (optional)
# Returns:
#   JSON repository object or the filtered result
# ------------------------------------------------------------------------------
hass.api.addons.repositories.info() {
    local repository=${1}
    local filter=${2:-}
    local repositories
    local result
    hass.log.trace "${FUNCNAME[0]}" "$@"
    repositories=$(hass.api.addons.repositories)
    result=$(hass.jq "${repositories}" \
        ".[] | select(.slug==\"${repository}\")")

    if hass.has_value "${filter}"; then
        hass.log.debug "Filtering response using: ${filter}"
        result=$(hass.jq "${result}" "${filter}")
    fi

    echo "${result}"
    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# Returns the name of a repository
#
# Arguments:
#   $1 Repository slug
# Returns:
#   Name of the repository
# ------------------------------------------------------------------------------
hass.api.addons.repositories.info.name() {
    local repository=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.repositories.info "${repository}" ".name"
}

# ------------------------------------------------------------------------------
# Returns the name of a repository
#
# Arguments:
#   $1 Repository slug
# Returns:
#   Name of the repository
# ------------------------------------------------------------------------------
hass.api.addons.repositories.info.source() {
    local repository=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.repositories.info "${repository}" ".source"
}

# ------------------------------------------------------------------------------
# Returns the URL of a repository
#
# Arguments:
#   $1 Repository slug
# Returns:
#   URL to the source of the repository
# ------------------------------------------------------------------------------
hass.api.addons.repositories.info.url() {
    local repository=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.repositories.info "${repository}" ".url"
}

# ------------------------------------------------------------------------------
# Returns the maintainer of a repository
#
# Arguments:
#   $1 Repository slug
# Returns:
#   Maintainer of the repository
# ------------------------------------------------------------------------------
hass.api.addons.repositories.info.maintainer() {
    local repository=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.repositories.info "${repository}" ".maintainer"
}

# ------------------------------------------------------------------------------
# Reload the list of addons and version from remote repositories
#
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.reload() {
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call POST /addons/reload
}

# ------------------------------------------------------------------------------
# Gives all available information for an add-on
#
# Arguments:
#   $1 Add-on slug
#   $2 jq Filter to apply on the result (optional)
# Returns:
#   JSON repository object or the filtered result
# ------------------------------------------------------------------------------
hass.api.addons.info() {
    local addon=${1}
    local filter=${2:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET "/addons/${addon}/info" false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns the name of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Name of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.name() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".name"
}

# ------------------------------------------------------------------------------
# Returns the description of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Description of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.description() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".description"
}

# ------------------------------------------------------------------------------
# Returns the long description of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Description of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.long_description() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".long_description"
}

# ------------------------------------------------------------------------------
# Returns whether or not auto update is enabled for this add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not auto update is enabled for this add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.auto_update() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".auto_update // false"
}

# ------------------------------------------------------------------------------
# Returns the URL of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   URL of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.url() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".url"
}

# ------------------------------------------------------------------------------
# Returns whether or not the add-on is running deattached
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not the add-on is running deattached
# ------------------------------------------------------------------------------
hass.api.addons.info.detached() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".detached // false"
}

# ------------------------------------------------------------------------------
# Returns the repository slug of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Respository slug of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.repository() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".repository"
}

# ------------------------------------------------------------------------------
# Returns the version of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Version of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.version() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".version"
}

# ------------------------------------------------------------------------------
# Returns the latest version of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Latest version of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.last_version() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".last_version"
}

# ------------------------------------------------------------------------------
# Returns the current state of an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   The current state of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.state() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".state"
}

# ------------------------------------------------------------------------------
# Returns the current boot setting of this add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Boot setting of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.boot() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".boot"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on is being build locally
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on is being build locally
# ------------------------------------------------------------------------------
hass.api.addons.info.build() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".build // false"
}

# ------------------------------------------------------------------------------
# Returns options for this add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   JSON ojbect
# ------------------------------------------------------------------------------
hass.api.addons.info.boot() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".options[]"
}

# ------------------------------------------------------------------------------
# Returns a list of ports which are exposed on the host network for this add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   List of network ports
# ------------------------------------------------------------------------------
hass.api.addons.info.network() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".network"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on runs on the host network
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on is running on the host network
# ------------------------------------------------------------------------------
hass.api.addons.info.host_network() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".host_network // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on has IPC access
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on has IPC access
# ------------------------------------------------------------------------------
hass.api.addons.info.host_ipc() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".host_ipc // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on has DBus access to the host
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on has DBus access
# ------------------------------------------------------------------------------
hass.api.addons.info.host_dbus() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".host_dbus // false"
}

# ------------------------------------------------------------------------------
# Returns the privileges the add-on has on to the hardware / system.
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   List of privileges
# ------------------------------------------------------------------------------
hass.api.addons.info.privileged() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".privileged // empty"
}

# ------------------------------------------------------------------------------
# Returns the current apparmor state of this add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Seccomp state: disable, default or profile
# ------------------------------------------------------------------------------
hass.api.addons.info.apparmor() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".apparmor"
}

# ------------------------------------------------------------------------------
# Returns a list devices made available to the add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   List of devices
# ------------------------------------------------------------------------------
hass.api.addons.info.devices() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".devices"
}

# ------------------------------------------------------------------------------
# Returns if UART was made available to the add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on as automatic UART enabled
# ------------------------------------------------------------------------------
hass.api.addons.info.auto_uart() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".auto_uart // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on has a icon available
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on has a icon available
# ------------------------------------------------------------------------------
hass.api.addons.info.icon() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".icon // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on has a logo available
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on has a logo available
# ------------------------------------------------------------------------------
hass.api.addons.info.logo() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".logo // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on has a changelog available
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on has a changelog available
# ------------------------------------------------------------------------------
hass.api.addons.info.changelog() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".changelog // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on can access the Hass.io API
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on can access the Hass.io API
# ------------------------------------------------------------------------------
hass.api.addons.info.hassio_api() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".hassio_api // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on can access the Home Assistant API
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on can access the Home Assistant API
# ------------------------------------------------------------------------------
hass.api.addons.info.homeassistant_api() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".homeassistant_api // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on can use the STDIN on the Hass.io API
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on can use the STDIN
# ------------------------------------------------------------------------------
hass.api.addons.info.stdin() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".stdin // false"
}

# ------------------------------------------------------------------------------
# A URL for web interface of this add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   The webui URL of the add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.webui() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".webui // empty"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on can access GPIO
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on can access GPIO
# ------------------------------------------------------------------------------
hass.api.addons.info.gpio() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".gpio // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on can access the devicetree
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on can access the devicetree
# ------------------------------------------------------------------------------
hass.api.addons.info.devicetree() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".devicetree // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on can access the Docker socket
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on can access the Docker socket
# ------------------------------------------------------------------------------
hass.api.addons.info.docker_api() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".docker_api // false"
}

# ------------------------------------------------------------------------------
# Returns whether or not this add-on can access an audio device
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Whether or not this add-on can access an audio device
# ------------------------------------------------------------------------------
hass.api.addons.info.audio() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".audio // false"
}

# ------------------------------------------------------------------------------
# Returns the available audio input device for an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   the available audio input device for an add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.audio_input() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".audio_input // empty"
}

# ------------------------------------------------------------------------------
# Returns the available audio output device for an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   the available audio output device for an add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.audio_output() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".audio_output // empty"
}

# ------------------------------------------------------------------------------
# Returns the available services for an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   The available services for this add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.services() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".services // empty"
}

# ------------------------------------------------------------------------------
# Returns the available discovery items for an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   The available discovery items for this add-on
# ------------------------------------------------------------------------------
hass.api.addons.info.discovery() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.info "${addon}" ".discovery // empty"
}

# ------------------------------------------------------------------------------
# Starts an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.start() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/addons/${addon}/start"
}

# ------------------------------------------------------------------------------
# Stops an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.stop() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/addons/${addon}/stop"
}

# ------------------------------------------------------------------------------
# Install an add-on onto your Hass.io instance
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.install() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/addons/${addon}/install"
}

# ------------------------------------------------------------------------------
# Uninstall an add-on from your Hass.io instance
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.uninstall() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/addons/${addon}/uninstall"
}

# ------------------------------------------------------------------------------
# Updates an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.update() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/addons/${addon}/update"
}

# ------------------------------------------------------------------------------
# Returns the logs created by an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   The logs in text format
# ------------------------------------------------------------------------------
hass.api.addons.logs() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}"
    hass.api.call GET "/addons/${addon}/logs" true
}

# ------------------------------------------------------------------------------
# Restarts an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.restart() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/addons/${addon}/restart"
}

# ------------------------------------------------------------------------------
# Rebuilds an add-on locally
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.rebuild() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call POST "/addons/${addon}/rebuild"
}

# ------------------------------------------------------------------------------
# Checks if there is an update available for an add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   None
# ------------------------------------------------------------------------------
hass.api.addons.update_available() {
    local addon=${1}
    local version
    local last_version

    hass.log.trace "${FUNCNAME[0]}"

    version=$(hass.api.addons.info.version "${addon}")
    last_version=$(hass.api.addons.info.last_version "${addon}")

    if [[ "${version}" = "${last_version}" ]]; then
        return "${EX_NOK}"
    fi

    return "${EX_OK}"
}

# ------------------------------------------------------------------------------
# List all available stats about add-ons
#
# Arguments:
#   $1 Add-on slug
#   $2 jq Filter to apply on the result (optional)
# Returns:
#   JSON object
# ------------------------------------------------------------------------------
hass.api.addons.stats() {
    local addon=${1}
    local filter=${2:-}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.call GET GET "/addons/${addon}/logs" false "${filter}"
}

# ------------------------------------------------------------------------------
# Returns CPU usage from add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Usage in percent
# ------------------------------------------------------------------------------
hass.api.addons.stats.cpu_percent() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.stats "${addon}" ".cpu_percent"
}

# ------------------------------------------------------------------------------
# Returns memory usage from add-on
# Arguments:
#   $1 Add-on slug
# Returns:
#   Usage in Mb
# ------------------------------------------------------------------------------
hass.api.addons.stats.memory_usage() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.stats "${addon}" ".memory_usage"
}

# ------------------------------------------------------------------------------
# Returns memory limit from add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Usage in Mb
# ------------------------------------------------------------------------------
hass.api.addons.stats.memory_limit() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.stats "${addon}" ".memory_limit"
}

# ------------------------------------------------------------------------------
# Returns outgoing network usage from add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Usage in Mb
# ------------------------------------------------------------------------------
hass.api.addons.stats.network_tx() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.stats "${addon}" ".network_tx"
}

# ------------------------------------------------------------------------------
# Returns incoming network usage from add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Usage in Bytes
# ------------------------------------------------------------------------------
hass.api.addons.stats.network_rx() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.stats "${addon}" ".network_rx"
}

# ------------------------------------------------------------------------------
# Returns disk read usage from add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Usage in Blocks
# ------------------------------------------------------------------------------
hass.api.addons.stats.blk_read() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.stats "${addon}" ".blk_read"
}

# ------------------------------------------------------------------------------
# Returns disk write usage from add-on
#
# Arguments:
#   $1 Add-on slug
# Returns:
#   Usage in Blocks
# ------------------------------------------------------------------------------
hass.api.addons.stats.blk_write() {
    local addon=${1}
    hass.log.trace "${FUNCNAME[0]}" "$@"
    hass.api.addons.stats "${addon}" ".blk_write"
}
