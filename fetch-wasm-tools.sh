#!/bin/bash

# Get variables from input parameters
WASM_TOOLS_OS=linux
WASM_TOOLS_VERSION=$1
WASM_TOOLS_ARCH=$2
TARGETARCH=$3

if [ "${WASM_TOOLS_ARCH}" = "unset" ]; then
  if [ "${TARGETARCH}" = "arm64" ]; then
    SCRIPT_WASM_TOOLS_ARCH="aarch64"
  elif [ "${TARGETARCH}" = "amd64" ]; then
    SCRIPT_WASM_TOOLS_ARCH="x86_64"
  fi
else
  SCRIPT_WASM_TOOLS_ARCH=${WASM_TOOLS_ARCH}
fi

# just download, unpack and link, much like above
cd /usr/local
BASE=wasm-tools-${WASM_TOOLS_VERSION}-${SCRIPT_WASM_TOOLS_ARCH}-${WASM_TOOLS_OS}
FILE=${BASE}.tar.gz
wget https://github.com/bytecodealliance/wasm-tools/releases/download/v${WASM_TOOLS_VERSION}/${FILE}
tar xvf ${FILE}
ln -s /usr/local/${BASE}/wasm-tools /usr/local/bin/wasm-tools
