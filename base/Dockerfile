ARG BUILD_FROM=alpine:3.6
FROM ${BUILD_FROM}

# Environment variables
ENV \
    HOME="/root" \
    LANG="C.UTF-8" \
    PS1="$(whoami)@$(hostname):$(pwd)$ " \
    TERM="xterm"

# Copy root filesystem
COPY rootfs /

# Install base system
ARG BUILD_ARCH
ARG S6_OVERLAY_VERSION="v1.20.0.0"
RUN \
    apk add --no-cache --virtual .build-dependencies \
        curl \
        tar \
    \
    && apk add --no-cache \
        bash \
        ca-certificates \
        eudev \
        jq \
        tzdata \
    \
    && if [[ "${BUILD_ARCH}" = "i386" ]]; then S6_ARCH="x86"; else S6_ARCH="${BUILD_ARCH}"; fi \
    \
    && curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCH}.tar.gz" \
        | tar zxvf - -C / \
    \
    && mkdir -p \
        /etc/cont-finish.d \
        /etc/cont-init.d \
        /etc/fix-attrs.d \
        /etc/services.d \
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
