ARG ALPINE_TAG=3.10
ARG HAPROXY_VER=2.0.8

FROM loxoo/alpine:${ALPINE_TAG} AS builder

ARG HAPROXY_VER

### install haaproxy
WORKDIR /haproxy-src
RUN apk add --no-cache build-base linux-headers lua5.3-dev pcre2-dev openssl-dev; \
    wget http://www.haproxy.org/download/2.0/src/haproxy-${HAPROXY_VER}.tar.gz -O haproxy.tar.gz; \
    tar xvzf haproxy.tar.gz --strip-components=1; \
    make all TARGET=linux-glibc USE_GETADDRINFO=1 USE_LUA=1 LUA_INC=/usr/include/lua5.3 \
        LUA_LIB=/usr/lib/lua5.3 USE_OPENSSL=1 USE_PCRE2=1 USE_PCRE2_JIT=1 USE_ZLIB=1; \
    make install-bin DESTDIR=/output PREFIX=/haproxy; \
    find /output -exec sh -c 'file "{}" | grep -q ELF && strip --strip-debug "{}"' \;

#=============================================================

FROM loxoo/alpine:${ALPINE_TAG}

ARG HAPROXY_VER
ENV SUID=902 SGID=902
