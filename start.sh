#!/bin/bash

if [ "$1" = "wasmtime" ]; then
  CMD=/usr/local/bin/wasmtime
  shift
else
  CMD="dotnet"
fi

${CMD} "$@"

