FROM arm32v6/alpine:3.6

# Internal arguments
ARG S6_OVERLAY_VERSION="v1.20.0.0"

# Environment variables
ENV \
    HOME="/root" \
    LANG="C.UTF-8" \
    PS1="$(whoami)@$(hostname):$(pwd)$ " \
    TERM="xterm"

# Copy root filesystem
COPY rootfs /

# Install base system
RUN \
# Install build dependencies
    apk add --no-cache --virtual .build-dependencies \
        curl \
        tar \
    \
    && apk add --no-cache \
        ca-certificates \
        eudev \
        jq \
        tzdata \
    \
    && curl -L -s \
        "https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-armhf.tar.gz" \
        | tar zxvf - -C / \
    \
    && apk del --purge .build-dependencies \
    \
    && mkdir -p \
        /etc/cont-finish.d \
        /etc/cont-init.d \
        /etc/fix-attrs.d \
        /etc/services.d \
    \
    && rm -f -r \
        /tmp/*

# Entrypoint & CMD
ENTRYPOINT [ "/init" ]

# Build arugments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.arch="armhf" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Community Hass.io Add-ons: armhf Base image" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Addon base for armhf" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="http://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-base/blob/master/README.md" \
    org.label-schema.vcs-ref=${REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-base" \
    org.label-schema.vendor="Franck Nijhof"
