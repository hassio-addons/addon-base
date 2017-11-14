# Community Hass.io Add-ons: Base Images

All notable changes to this add-on will be documented in this file.

The format is based on [Keep a Changelog][keep-a-changelog]
and this project adheres to [Semantic Versioning][semantic-versioning].

## Unreleased

### Changes

- Updated README to match style of other add-ons

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
[v1.0.1]: https://github.com/hassio-addons/addon-base/tree/v1.0.1