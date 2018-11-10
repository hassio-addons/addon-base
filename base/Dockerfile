ARG BUILD_FROM=alpine:3.8
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

# Copy yq
ARG BUILD_ARCH=amd64
COPY bin/yq_${BUILD_ARCH} /usr/bin/yq

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install base system
RUN \
    set -o pipefail \
    \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    \
    && apk add --no-cache --virtual .build-dependencies \
        tar=1.30-r0 \
    \
    && apk add --no-cache \
        apk-tools=2.10.1-r0 \
        bash=4.4.19-r1 \
        busybox=1.28.4-r1 \
        ca-certificates=20171114-r3 \
        curl=7.61.1-r0 \
        jq=1.6_rc1-r1 \
        musl-utils=1.1.19-r10 \
        musl=1.1.19-r10 \
        tzdata=2018f-r0 \
    \
    && if [ "${BUILD_ARCH}" = "i386" ]; then S6_ARCH="x86"; else S6_ARCH="${BUILD_ARCH}"; fi \
    \
    && curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-${S6_ARCH}.tar.gz" \
        | tar zxvf - -C / \
    \
    && mkdir -p /etc/fix-attrs.d \
    && mkdir -p /etc/services.d \
    \
    && apk del --purge .build-dependencies \
    && rm -f -r \
        /tmp/*

# Entrypoint & CMD
ENTRYPOINT ["/init"]

# Build arugments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="base" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Community Hass.io Add-ons: ${BUILD_ARCH} Base image" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Addon base for ${BUILD_ARCH}" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-base/blob/master/README.md" \
    org.label-schema.vcs-ref=${REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-base" \
    org.label-schema.vendor="Franck Nijhof"
