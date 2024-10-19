FROM mcr.microsoft.com/dotnet/sdk:8.0

WORKDIR /usr/local

ARG WASI_OS=linux
ARG WASI_VERSION=24
ARG WASI_VERSION_FULL=${WASI_VERSION}.0
ARG WASMTIME_VERSION=v25.0.2
ARG WASMTIME_OS=linux

ARG WASI_ARCH=unset
ARG WASMTIME_ARCH=unset

ARG TARGETARCH
RUN echo "Targeting ${TARGETARCH}"

# need xz for the wasmtime archive
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y xz-utils \
  && rm -rf /var/lib/apt/lists/*

COPY ./fetch-wasi-sdk.sh /usr/local/bin
COPY ./fetch-wasmtime.sh /usr/local/bin
RUN chmod +x /usr/local/bin/fetch-wasi-sdk.sh /usr/local/bin/fetch-wasmtime.sh
RUN /usr/local/bin/fetch-wasi-sdk.sh "${WASI_VERSION}" "${WASI_VERSION_FULL}" "${WASI_ARCH}" "${TARGETARCH}"
RUN /usr/local/bin/fetch-wasmtime.sh "${WASMTIME_VERSION}" "${WASMTIME_ARCH}" "${TARGETARCH}"

# now about those .NET workloads
RUN dotnet workload install wasm-experimental wasm-tools wasi-experimental

COPY ./start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

WORKDIR /src

ENTRYPOINT ["/usr/local/bin/start.sh"]

CMD ["build"]
