#!/bin/bash

if [ "$1" = "wasmtime" ]; then
  CMD=/usr/local/bin/wasmtime
  shift
elif [ "$1" = "wasm-tools" ]; then
  CMD=/usr/local/bin/wasm-tools
  shift
else
  CMD="dotnet"
fi

${CMD} "$@"

