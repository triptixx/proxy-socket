[hub]: https://hub.docker.com/r/loxoo/proxy-socket
[mbdg]: https://microbadger.com/images/loxoo/proxy-socket
[git]: https://github.com/triptixx/proxy-socket
[actions]: https://github.com/triptixx/proxy-socket/actions

# [loxoo/proxy-socket][hub]
[![Layers](https://images.microbadger.com/badges/image/loxoo/proxy-socket.svg)][mbdg]
[![Latest Version](https://images.microbadger.com/badges/version/loxoo/proxy-socket.svg)][hub]
[![Git Commit](https://images.microbadger.com/badges/commit/loxoo/proxy-socket.svg)][git]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/proxy-socket.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/proxy-socket.svg)][hub]
[![Build Status](https://github.com/triptixx/proxy-socket/workflows/docker%20build/badge.svg)][actions]

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
