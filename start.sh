#!/bin/bash

# prepare the environment
export WASI_SDK_PATH=$(cat /usr/local/wasi-sdk-path)

if [ "$1" = "wasmtime" ]; then
  CMD=/usr/local/bin/wasmtime
  shift
else
  CMD="dotnet"
fi

echo "Remaining arguments:" "$@"

${CMD} "$@"

