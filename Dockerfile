ARG PHP_VERSION
FROM dunglas/frankenphp:1-builder-php${PHP_VERSION} AS builder
COPY --from=caddy:builder /usr/bin/xcaddy /usr/bin/xcaddy
RUN apt-get update && apt-get install -y git
ENV CGO_ENABLED=1 XCADDY_SETCAP=1 XCADDY_GO_BUILD_FLAGS="-ldflags \"-w -s -extldflags '-Wl,-z,stack-size=0x80000'\""
RUN xcaddy build \
    --output /usr/local/bin/frankenphp \
    --with github.com/dunglas/frankenphp/caddy \
    --with github.com/dunglas/mercure/caddy \
    --with github.com/dunglas/vulcain/caddy \
    --with github.com/dunglas/caddy-cbrotli \
    --with github.com/darkweak/souin/plugins/caddy \
    --with github.com/darkweak/storages/otter/caddy
