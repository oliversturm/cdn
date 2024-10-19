#!/bin/bash

WASI_VERSION=$1
WASI_VERSION_FULL=$2
WASI_ARCH=$3
# just Linux right now
WASI_OS=linux
TARGETARCH=$4


if [ "${WASI_ARCH}" = "unset" ]; then
  if [ "${TARGETARCH}" = "arm64" ]; then
    SCRIPT_WASI_ARCH="arm64"
  elif [ "${TARGETARCH}" = "amd64" ]; then
    SCRIPT_WASI_ARCH="x86_64"
  fi
else
  SCRIPT_WASI_ARCH=${WASI_ARCH}
fi

# from https://github.com/WebAssembly/wasi-sdk

cd /usr/local
FILE=wasi-sdk-${WASI_VERSION_FULL}-${SCRIPT_WASI_ARCH}-${WASI_OS}.tar.gz
wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/${FILE}
tar xvf ${FILE}

WASI_SDK_PATH=/usr/local/wasi-sdk-${WASI_VERSION_FULL}-${SCRIPT_WASI_ARCH}-${WASI_OS}

touch ${WASI_SDK_PATH}/VERSION${WASI_VERSION}
echo "${WASI_SDK_PATH}" > ./wasi-sdk-path
