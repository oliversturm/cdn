#!/bin/bash

# prepare the environment
export WASI_SDK_PATH=$(cat /usr/local/wasi-sdk-path)

# figure out the command to run
if [ "$1" = "wasmtime" ]; then
  CMD=/usr/local/bin/wasmtime
  shift
else
  CMD="dotnet"
fi

${CMD} "$@"

