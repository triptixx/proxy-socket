ARG ALPINE_TAG=3.10
ARG HAPROXY_VER=2.0.8

FROM loxoo/alpine:${ALPINE_TAG} AS builder

ARG HAPROXY_VER

### install haaproxy
WORKDIR /haproxy-src
RUN apk add --no-cache build-base linux-headers lua5.3-dev pcre2-dev openssl-dev; \
    wget http://www.haproxy.org/download/${HAPROXY_VER:0:3}/src/haproxy-${HAPROXY_VER}.tar.gz -O haproxy.tar.gz; \
    tar xvzf haproxy.tar.gz --strip-components=1; \
    make all TARGET=linux-glibc USE_GETADDRINFO=1 USE_LUA=1 LUA_INC=/usr/include/lua5.3 \
        LUA_LIB=/usr/lib/lua5.3 USE_OPENSSL=1 USE_PCRE2=1 USE_PCRE2_JIT=1 USE_ZLIB=1; \
    make install-bin DESTDIR=/output PREFIX=/haproxy; \
    cp -R examples/errorfiles /output/haproxy/errors; \
    find /output -exec sh -c 'file "{}" | grep -q ELF && strip --strip-debug "{}"' \;

COPY *.cfg /output/haproxy/

#=============================================================

FROM loxoo/alpine:${ALPINE_TAG}

ARG HAPROXY_VER
ENV SUID=902 SGID=902 \
    ALLOW_RESTARTS=0 \
    AUTH=0 \
    BUILD=0 \
    COMMIT=0 \
    CONFIGS=0 \
    CONTAINERS=0 \
    DISTRIBUTION=0 \
    EVENTS=1 \
    EXEC=0 \
    IMAGES=0 \
    INFO=0 \
    LOG_LEVEL=info \
    NETWORKS=0 \
    NODES=0 \
    PING=1 \
    PLUGINS=0 \
    POST=0 \
    SECRETS=0 \
    SERVICES=0 \
    SESSION=0 \
    SWARM=0 \
    SYSTEM=0 \
    TASKS=0 \
    VERSION=1 \
    VOLUMES=0

LABEL org.label-schema.name="haproxy" \
      org.label-schema.description="A Docker image for Docker socket to restrict with haproxy" \
      org.label-schema.url="http://www.haproxy.org/" \
      org.label-schema.version=${HAPROXY_VER}

COPY --from=builder /output/ /

RUN apk add --no-cache lua5.3-libs pcre2

VOLUME ["/var/run/docker.sock"]

EXPOSE 2375/TCP

HEALTHCHECK --start-period=10s --timeout=5s \
    CMD wget -qO /dev/null "http://localhost:2375/_ping"

CMD ["/haproxy/sbin/haproxy", "-f", "/haproxy/haproxy.cfg"]
