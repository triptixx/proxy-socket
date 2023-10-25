[hub]: https://hub.docker.com/r/loxoo/proxy-socket
[git]: https://github.com/triptixx/proxy-socket/tree/master
[actions]: https://github.com/triptixx/proxy-socket/actions/workflows/main.yml

# [loxoo/proxy-socket][hub]
[![Git Commit](https://img.shields.io/github/last-commit/triptixx/proxy-socket/master)][git]
[![Build Status](https://github.com/triptixx/proxy-socket/actions/workflows/main.yml/badge.svg?branch=master)][actions]
[![Latest Version](https://img.shields.io/docker/v/loxoo/proxy-socket/latest)][hub]
[![Size](https://img.shields.io/docker/image-size/loxoo/proxy-socket/latest)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/proxy-socket.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/proxy-socket.svg)][hub]

## Usage

```shell
docker run -d \
    --name=srvproxy-socket \
    --restart=unless-stopped \
    --hostname=srvproxy-socket \
    --privileged \
    -p 127.0.0.1:2375:2375 \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    loxoo/proxy-socket
```

## Environment

### Access granted by default

These API sections are mostly harmless and almost required for any service that
uses the API, so they are granted by default.

- `$EVENTS`
- `$PING`
- `$VERSION`

### Access revoked by default

#### Security-critical

These API sections are considered security-critical, and thus access is revoked
by default. Maximum caution when enabling these.

- `$ALLOW_RESTARTS`
- `$AUTH`
- `$SECRETS`
- `$POST`: When disabled, only `GET` and `HEAD` operations are allowed, meaning
  any section of the API is read-only.

#### Not always needed

You will possibly need to grant access to some of these API sections, which are
not so extremely critical but can expose some information that your service
does not need.

- `$BUILD`
- `$COMMIT`
- `$CONFIGS`
- `$CONTAINERS`
- `$DISTRIBUTION`
- `$EXEC`
- `$IMAGES`
- `$INFO`
- `$NETWORKS`
- `$NODES`
- `$PLUGINS`
- `$SERVICES`
- `$SESSION`
- `$SWARM`
- `$SYSTEM`
- `$TASKS`
- `$VOLUMES`
- `$LOG_LEVEL`    - Logging severity levels. _default: `info`_
- `$TZ`           - Timezone. _optional_

## Volume

- `/var/run/docker.sock`       - A path for the UNIX socket of Docker daemon.

## Network

- `2375/tcp`        - Tcp socket listening port.
