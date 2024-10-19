#!/bin/bash

# Get variables from input parameters
WASMTIME_OS=linux
WASMTIME_VERSION=$1
WASMTIME_ARCH=$2
TARGETARCH=$3

if [ "${WASMTIME_ARCH}" = "unset" ]; then
  if [ "${TARGETARCH}" = "arm64" ]; then
    SCRIPT_WASMTIME_ARCH="aarch64"
  elif [ "${TARGETARCH}" = "amd64" ]; then
    SCRIPT_WASMTIME_ARCH="x86_64"
  fi
else
  SCRIPT_WASMTIME_ARCH=${WASMTIME_ARCH}
fi

# just download, unpack and link, much like above
cd /usr/local
BASE=wasmtime-${WASMTIME_VERSION}-${SCRIPT_WASMTIME_ARCH}-${WASMTIME_OS}
FILE=${BASE}.tar.xz
wget https://github.com/bytecodealliance/wasmtime/releases/download/${WASMTIME_VERSION}/${FILE}
tar xvf ${FILE}
ln -s /usr/local/${BASE}/wasmtime /usr/local/bin/wasmtime
