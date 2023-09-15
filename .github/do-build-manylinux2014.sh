#!/bin/sh

set -x

OTP_VERSION=$1
ARCH=$2

OPENSSL_VERSION=${OPENSSL_VERSION:-3.1.1}
ASDF_VERSION=${ASDF_VERSION:-v0.12.0}
PERFIX_DIR="/openssl-${ARCH}"
OPENSSL_ARCHIVE="openssl-${ARCH}.tar.gz"

cd / && \
    curl -fSL "https://github.com/cocoa-xu/elixir_make-manylinux-openssl-precompiled/releases/download/v${OPENSSL_VERSION}/${OPENSSL_ARCHIVE}" -o "${OPENSSL_ARCHIVE}" && \
    tar -xf "${OPENSSL_ARCHIVE}" && \
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "${ASDF_VERSION}" && \
    . "/root/.asdf/asdf.sh" && \
    export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=${PERFIX_DIR}" && \
    asdf plugin add erlang && \
    asdf install erlang "${OTP_VERSION}" && \
    cd "/root/.asdf/installs/erlang" && \
    tar -czf "/work/otp-${ARCH}.tar.gz" "${OTP_VERSION}"
