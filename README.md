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
    -v /var/run/docker.sock:/var/run/docker.sock \
    loxoo/proxy-socket
```

## Environment

- `$SUID`         - User ID to run as. _default: `901`_
- `$SGID`         - Group ID to run as. _default: `901`_
- `$DOMAIN`       - Domain master zone. _required_
- `$NS2`          - Fqdn name of slave server zone. _required_
- `$MX`           - Name of mail server. _optional_
- `$CNAME`        - Name of different subdomain. Separated by commas. _optional_
- `$ENDPOINT`     - Name server of Gandi API. _optional_
- `$APIKEY`       - Authentication Gandi API Key. _optional_
- `$LOG_LEVEL`    - Logging severity levels. _default: `info`_
- `$TZ`           - Timezone. _optional_

## Volume

- `/rundir`       - A path for storing run-time data.
- `/storage`      - A data directory for storing zone files, journal database, and timers database.
- `/config`       - Server configuration file location.

## Network

- `53/udp`        - Dns port udp.
- `53/tcp`        - Dns port tcp.
