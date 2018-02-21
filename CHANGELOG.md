# Community Hass.io Add-ons: Base Images

All notable changes to this add-on will be documented in this file.

The format is based on [Keep a Changelog][keep-a-changelog]
and this project adheres to [Semantic Versioning][semantic-versioning].

## Unreleased

### Fixed

- Add-on banner throws hassio.api.security warnings

### Changed

- Update all Alpine packages on build

## [v1.3.2] (2018-01-18)

[Full Changelog][v1.3.1-v1.3.2]

### Changed

- Upgrades semver cli to v0.3.0
- Rename Hassio API token #19 (@pvizeli)

## [v1.3.1] (2018-01-06)

[Full Changelog][v1.3.0-v1.3.1]

### Changed

- Updated Bash Hass.io library to match Hass.io 0.79 API
- Upgraded S6-overlay to v1.21.2.2
- Updated maintenance year, it is 2018

## [v1.3.0] (2017-12-23)

[Full Changelog][v1.2.0-v1.3.0]

### Added

- Adds version requirements checks for HA and Supervisor

### Changed

- Prevents possible future Docker login issue
- Pass local CircleCI Docker socket into the build container
- Enable Docker experimental features in CircleCI
- Upgrades Qemu binaries to v2.10.1, download on build
- Moved download of Qemu binaries in CircleCI
- Adds base/rootfs/usr/bin/qemu-* to .gitignore
- Updates forum link in README
- Upgrades semver tool to v0.2.0
- Upgrades QEMU to v2.11.0 (#18)

### Fixed

- Fixes typos in latest version number of the CHANGELOG
- Fixes issue in version check logic

### Removed

- Removed Microbadger notification hooks
- Removes cont-finish directory creation from Dockerfile

## [v1.2.0] (2017-12-02)

[Full Changelog][v1.1.0-v1.2.0]

### Added

- Informational final message when container terminates by error
- Added support for Hass.io API tokens

### Changed

- Upgraded to Alpine 3.7
- Upgraded S6-overlay to v1.21.2.1

## [v1.1.0] (2017-11-15)

[Full Changelog][v1.0.1-v1.1.0]

### Added

- Added `service` command that emulates systemd behavior for S6

### Changed

- Updated README to match style of other add-ons
- Upgraded Qemu static binaries to v2.9.1

## [v1.0.1] (2017-10-25)

[Full Changelog][v1.0.0-v1.0.1]

### Change

- Added extra debug output when curl API call fails #11

## [v1.0.0] (2017-10-15)

[Full Changelog][v0.0.2-v1.0.0]

### Added

- Bash function library for add-ons
- `curl` is now installed by default
- Automated add-on startup banner, including version information
- Automated upgrade notification of add-on in the logs
- Handling of log level via `log_level` Hass.io add-on options

### Changed

- S6 stage 2 issues, will now cause termination of the container
- S6 waits for all services to start before executing CMD
- Updated/tweaked the documentation

### Removed

- Removes Docker build arg: S6_OVERLAY_VERSION

## [v0.0.2] (2017-09-26)

[Full Changelog][v0.0.1-v0.0.2]
### Changed

- Updated add-on to support new build environment #8

## [v0.0.1] (2017-09-21)

### Added

- Initial version, first release.

[keep-a-changelog]: http://keepachangelog.com/en/1.0.0/
[semantic-versioning]: http://semver.org/spec/v2.0.0.html
[v0.0.1-v0.0.2]: https://github.com/hassio-addons/addon-base/compare/v0.0.1...v0.0.2
[v0.0.1]: https://github.com/hassio-addons/addon-base/tree/v0.0.1
[v0.0.2-v1.0.0]: https://github.com/hassio-addons/addon-base/compare/v0.0.2...v1.0.0
[v0.0.2]: https://github.com/hassio-addons/addon-base/tree/v0.0.2
[v1.0.0-v1.0.1]: https://github.com/hassio-addons/addon-base/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/hassio-addons/addon-base/tree/v1.0.0
[v1.0.1-v1.1.0]: https://github.com/hassio-addons/addon-base/compare/v1.0.1...v1.1.0
[v1.0.1]: https://github.com/hassio-addons/addon-base/tree/v1.0.1
[v1.1.0-v1.2.0]: https://github.com/hassio-addons/addon-base/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/hassio-addons/addon-base/tree/v1.1.0
[v1.2.0-v1.3.0]: https://github.com/hassio-addons/addon-base/compare/v1.2.0...v1.3.0
[v1.2.0]: https://github.com/hassio-addons/addon-base/tree/v1.2.0
[v1.3.0-v1.3.1]: https://github.com/hassio-addons/addon-base/compare/v1.3.0...v1.3.1
[v1.3.0]: https://github.com/hassio-addons/addon-base/tree/v1.3.0
[v1.3.1-v1.3.2]: https://github.com/hassio-addons/addon-base/compare/v1.3.1...v1.3.2
[v1.3.1]: https://github.com/hassio-addons/addon-base/tree/v1.3.1
[v1.3.2]: https://github.com/hassio-addons/addon-base/tree/v1.3.2
