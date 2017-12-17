# Community Hass.io Add-ons: Base Images

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
![Project Maintenance][maintenance-shield]
[![GitHub Activity][commits-shield]][commits]
[![License][license-shield]](LICENSE.md)

[![CircleCI][circleci-shield]][circleci]
[![Code Climate][codeclimate-shield]][codeclimate]
[![Bountysource][bountysource-shield]][bountysource]
[![Discord][discord-shield]][discord]
[![Community Forum][forum-shield]][forum]

[![Patreon][patreon-shield]][patreon]
[![PayPal][paypal-shield]][paypal]
[![Bitcoin][bitcoin-shield]][bitcoin]

Docker base images used by Community Hass.io Add-ons.

## About

These are the base images used by add-ons created by the Community Hass.io
Add-ons.

While Home Assistant provides base images, the images provided by this
repository contain some extras:

- Adds [s6] as a process supervisor.
- Adds `jq` & `curl`, since every add-on uses them.
- Adds Docker [Label Schema][label-schema] support.
- Adds a large Bash function library for use with an add-on.
- Handles logs, add-on startup banners and update notifications.
- Several small adjustments and improvements.

## Docker status

[![Docker Architecture][armhf-arch-shield]][armhf-dockerhub]
[![Docker Version][armhf-version-shield]][armhf-microbadger]
[![Docker Layers][armhf-layers-shield]][armhf-microbadger]
[![Docker Pulls][armhf-pulls-shield]][armhf-dockerhub]

[![Docker Architecture][aarch64-arch-shield]][aarch64-dockerhub]
[![Docker Version][aarch64-version-shield]][aarch64-microbadger]
[![Docker Layers][aarch64-layers-shield]][aarch64-microbadger]
[![Docker Pulls][aarch64-pulls-shield]][aarch64-dockerhub]

[![Docker Architecture][amd64-arch-shield]][amd64-dockerhub]
[![Docker Version][amd64-version-shield]][amd64-microbadger]
[![Docker Layers][amd64-layers-shield]][amd64-microbadger]
[![Docker Pulls][amd64-pulls-shield]][amd64-dockerhub]

[![Docker Architecture][i386-arch-shield]][i386-dockerhub]
[![Docker Version][i386-version-shield]][i386-microbadger]
[![Docker Layers][i386-layers-shield]][i386-microbadger]
[![Docker Pulls][i386-pulls-shield]][i386-dockerhub]

## Changelog & Releases

This repository keeps a [change log](CHANGELOG.md). The format of the log
is based on [Keep a Changelog][keepchangelog].

Releases are based on [Semantic Versioning][semver], and use the format
of ``MAJOR.MINOR.PATCH``. In a nutshell, the version will be incremented
based on the following:

- ``MAJOR``: Incompatible or major changes.
- ``MINOR``: Backwards-compatible new features and enhancements.
- ``PATCH``: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- The Home Assistant [Community Forum][forum].
- The Home Assistant [Discord Chat Server][discord] for general Home Assistant
  discussions and questions.
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We've set up a separate document for our
[contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## We have got some Hass.io add-ons for you

Want some more functionality to your Hass.io Home Assistant instance?

We have created multiple add-ons for Hass.io. For a full list, check out
our [GitHub Repository][repository].

## License

MIT License

Copyright (c) 2017 Franck Nijhof

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-arch-shield]: https://img.shields.io/badge/architecture-aarch64-blue.svg
[aarch64-dockerhub]: https://hub.docker.com/r/hassioaddons/base-aarch64
[aarch64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/base-aarch64.svg
[aarch64-microbadger]: https://microbadger.com/images/hassioaddons/base-aarch64
[aarch64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/base-aarch64.svg
[aarch64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/base-aarch64.svg
[amd64-arch-shield]: https://img.shields.io/badge/architecture-amd64-blue.svg
[amd64-dockerhub]: https://hub.docker.com/r/hassioaddons/base-amd64
[amd64-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/base-amd64.svg
[amd64-microbadger]: https://microbadger.com/images/hassioaddons/base-amd64
[amd64-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/base-amd64.svg
[amd64-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/base-amd64.svg
[armhf-arch-shield]: https://img.shields.io/badge/architecture-armhf-blue.svg
[armhf-dockerhub]: https://hub.docker.com/r/hassioaddons/base-armhf
[armhf-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/base-armhf.svg
[armhf-microbadger]: https://microbadger.com/images/hassioaddons/base-armhf
[armhf-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/base-armhf.svg
[armhf-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/base-armhf.svg
[bitcoin-shield]: https://img.shields.io/badge/donate-bitcoin-blue.svg
[bitcoin]: https://blockchain.info/payment_request?address=3GVzgN6NpVtfXnyg5dQnaujtqVTEDBCtAH
[bountysource-shield]: https://img.shields.io/bountysource/team/hassio-addons/activity.svg
[bountysource]: https://www.bountysource.com/teams/hassio-addons/issues
[circleci-shield]: https://img.shields.io/circleci/project/github/hassio-addons/addon-base.svg
[circleci]: https://circleci.com/gh/hassio-addons/addon-base
[codeclimate-shield]: https://img.shields.io/badge/code%20climate-protected-brightgreen.svg
[codeclimate]: https://codeclimate.com/github/hassio-addons/addon-base
[commits-shield]: https://img.shields.io/github/commit-activity/y/hassio-addons/addon-base.svg
[commits]: https://github.com/hassio-addons/addon-base/commits/master
[contributors]: https://github.com/hassio-addons/addon-base/graphs/contributors
[discord-shield]: https://img.shields.io/discord/330944238910963714.svg
[discord]: https://discord.gg/c5DvZ4e
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io/?u=frenck
[frenck]: https://github.com/frenck
[i386-arch-shield]: https://img.shields.io/badge/architecture-i386-blue.svg
[i386-dockerhub]: https://hub.docker.com/r/hassioaddons/base-i386
[i386-layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/base-i386.svg
[i386-microbadger]: https://microbadger.com/images/hassioaddons/base-i386
[i386-pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/base-i386.svg
[i386-version-shield]: https://images.microbadger.com/badges/version/hassioaddons/base-i386.svg
[issue]: https://github.com/hassio-addons/addon-base/issues
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[label-schema]: http://label-schema.org/
[license-shield]: https://img.shields.io/github/license/hassio-addons/addon-base.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2017.svg
[patreon-shield]: https://img.shields.io/badge/donate-patreon-blue.svg
[patreon]: https://www.patreon.com/frenck
[paypal-shield]: https://img.shields.io/badge/donate-paypal-blue.svg
[paypal]: https://www.paypal.me/FranckNijhof
[project-stage-shield]: https://img.shields.io/badge/Project%20Stage-Production%20Ready-brightgreen.svg
[reddit]: https://reddit.com/r/homeassistant
[releases-shield]: https://img.shields.io/github/release/hassio-addons/addon-base.svg
[releases]: https://github.com/hassio-addons/addon-base/releases
[repository]: https://github.com/hassio-addons/repository
[s6]: http://skarnet.org/software/s6/overview.html
[semver]: http://semver.org/spec/v2.0.0.html