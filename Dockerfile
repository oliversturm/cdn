FROM mcr.microsoft.com/dotnet/sdk:8.0

WORKDIR /usr/local

ARG WASI_OS=linux
ARG WASI_VERSION=25
ARG WASI_VERSION_FULL=${WASI_VERSION}.0
ARG WASMTIME_VERSION=v34.0.1
ARG WASMTIME_OS=linux
ARG WASM_TOOLS_VERSION=1.235.0
ARG WASM_TOOLS_OS=linux

ARG WASI_ARCH=unset
ARG WASMTIME_ARCH=unset
ARG WASM_TOOLS_ARCH=unset

ARG TARGETARCH
RUN echo "Targeting ${TARGETARCH}"

# need xz for the wasmtime archive
# python for AOT builds (Emscripten)
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y xz-utils python3 llvm nodejs binaryen \
    && rm -rf /var/lib/apt/lists/*

COPY ./fetch-wasi-sdk.sh /usr/local/bin
COPY ./fetch-wasmtime.sh /usr/local/bin
COPY ./fetch-wasm-tools.sh /usr/local/bin
RUN chmod +x /usr/local/bin/fetch-wasi-sdk.sh /usr/local/bin/fetch-wasmtime.sh /usr/local/bin/fetch-wasm-tools.sh
RUN /usr/local/bin/fetch-wasi-sdk.sh "${WASI_VERSION}" "${WASI_VERSION_FULL}" "${WASI_ARCH}" "${TARGETARCH}"
RUN /usr/local/bin/fetch-wasmtime.sh "${WASMTIME_VERSION}" "${WASMTIME_ARCH}" "${TARGETARCH}"
RUN /usr/local/bin/fetch-wasm-tools.sh "${WASM_TOOLS_VERSION}" "${WASM_TOOLS_ARCH}" "${TARGETARCH}"

# now about those .NET workloads
RUN dotnet workload install wasm-experimental wasm-tools wasi-experimental

COPY ./start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

WORKDIR /src

ENV WASI_SDK_PATH=/usr/local/wasi-sdk-current
ENV LLVM_ROOT=/usr/lib/llvm-14
ENV DOTNET_EMSCRIPTEN_LLVM_ROOT=${LLVM_ROOT}
ENV DOTNET_EMSCRIPTEN_NODE_JS=/usr/bin/node
ENV DOTNET_EMSCRIPTEN_BINARYEN_ROOT=/usr/bin

USER root

ENTRYPOINT ["/usr/local/bin/start.sh"]

CMD ["build"]
