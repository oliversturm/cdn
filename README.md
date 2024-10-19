# Containerized .NET (`cdn`)

A set of Docker images based on Microsoft SDK images, but with batteries included:

- WASI SDK
- wasmtime

Made to run `dotnet` and `wasmtime` commands directly for a host directory.

Examples:

```bash
# Default: run `dotnet build`
> docker run --rm -v $(pwd):/src oliversturm/ndc:<version>

# Sub-default: run `dotnet` with supplied arguments
> docker run --rm -v $(pwd):/src oliversturm/ndc:<version> watch test
> docker run --rm -v $(pwd):/src oliversturm/ndc:<version> publish
> docker run --rm -v $(pwd):/src oliversturm/ndc:<version> run

# Run `wasmtime` with any arguments
> docker run --rm -v $(pwd):/src oliversturm/ndc:<version> wasmtime run --dir . dotnet.wasm myproject
```

Versions currently supported:

- `8` -- latest .NET SDK 8.x (`mcr.microsoft.com/dotnet/sdk:8.0`)
- `9` -- latest .NET SDK 9.x (`mcr.microsoft.com/dotnet/sdk:9.0`)
