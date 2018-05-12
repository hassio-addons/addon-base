ARG BUILD_FROM=alpine:3.7
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Environment variables
ENV \
    HOME="/root" \
    LANG="C.UTF-8" \
    PS1="$(whoami)@$(hostname):$(pwd)$ " \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    TERM="xterm"

# Copy root filesystem
COPY rootfs /

# Install base system
ARG BUILD_ARCH=amd64
# hadolint ignore=DL3018
RUN \
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    \
    && apk add --no-cache --virtual .build-dependencies \
        tar=1.29-r1 \
    \
    && apk add --no-cache \
        apk-tools=2.9.1-r2 \
        bash=4.4.19-r1 \
        busybox=1.27.2-r8 \
        ca-certificates=20171114-r0 \
        curl=7.59.0-r0 \
        jq=1.5-r5 \
        musl-utils=1.1.18-r3 \
        musl=1.1.18-r3 \
        tzdata=2017c-r0 \
    \
    && if [[ "${BUILD_ARCH}" = "i386" ]]; then S6_ARCH="x86"; else S6_ARCH="${BUILD_ARCH}"; fi \
    \
    && curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/v1.21.4.0/s6-overlay-${S6_ARCH}.tar.gz" \
        | tar zxvf - -C / \
    \
    && mkdir -p /etc/fix-attrs.d \
    && mkdir -p /etc/services.d \
    \
    && apk del --purge .build-dependencies \
    \
    && \
        if [[ "${BUILD_ARCH}" != "armhf" ]]; then \
            rm -f /usr/bin/qemu-arm-static; \
        fi \
    \
    && \
        if [[ "${BUILD_ARCH}" != "aarch64" ]]; then \
            rm -f /usr/bin/qemu-aarch64-static; \
        fi \
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
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Community Hass.io Add-ons: ${BUILD_ARCH} Base image" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Addon base for ${BUILD_ARCH}" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="http://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-base/blob/master/README.md" \
    org.label-schema.vcs-ref=${REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-base" \
    org.label-schema.vendor="Franck Nijhof"
