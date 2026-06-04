# alpine-tor

Alpine-based container image for running Tor in four deployment modes:

- `proxy`
- `middle`
- `bridge`
- `exit`

The image builds Tor from source and provides a small entrypoint wrapper that generates the mode-specific `torrc` settings from environment variables.

## Docker Quickstart

Pull the published image:

```bash
docker pull jfwenisch/alpine-tor
```

Build locally:

```bash
docker build -t jfwenisch/alpine-tor .
```

Build a specific Tor version:

```bash
docker build -t jfwenisch/alpine-tor --build-arg TORVERSION=tor-0.4.9.9 .
```

## Modes

The container supports four modes through the `mode` environment variable.

### Proxy

Runs Tor as a client and exposes a SOCKS proxy.

```bash
docker run --rm -e mode=proxy -e SOCKSPort=9050 -p 9050:9050 jfwenisch/alpine-tor
```

### Middle

Runs a non-exit relay. This is the usual starting point for running a public Tor relay.

```bash
docker run --rm -e mode=middle -e ORPort=443 -p 443:443 jfwenisch/alpine-tor
```

### Bridge

Runs an obfs4 bridge. This requires both Tor's `ORPort` and a separate obfs4 transport port.

```bash
docker run --rm -e mode=bridge -e ORPort=443 -e TransportPort=4444 -p 443:443 -p 4444:4444 jfwenisch/alpine-tor
```

### Exit

Runs an exit relay. `ORPort` is required. `DirPort` is optional and deprecated upstream for most setups.

```bash
docker run --rm -e mode=exit -e ORPort=443 -p 443:443 jfwenisch/alpine-tor
```

If you want to serve an exit notice page anyway, also set `DirPort` and `DirPortFrontPage`.

## Kubernetes Manifests

Raw Kubernetes manifests live in [manifests/README.md](/c:/Git/alpine-tor/manifests/README.md).

Available files:

- `manifests/alpine-tor-proxy.deployment.yaml`
- `manifests/alpine-tor-middle.deployment.yaml`
- `manifests/alpine-tor-bridge.deployment.yaml`
- `manifests/alpine-tor-exit.deployment.yaml`

Quickstart:

```bash
kubectl apply -f manifests/alpine-tor-proxy.deployment.yaml
```

The detailed manifest descriptions, exposed ports, and file-by-file notes are in [manifests/README.md](/c:/Git/alpine-tor/manifests/README.md).

## Helm Chart

The Helm chart lives in [charts/README.md](/c:/Git/alpine-tor/charts/README.md).

Quickstart:

```bash
helm install alpine-tor-proxy ./charts --set mode=proxy
```

Bridge example:

```bash
helm install alpine-tor-bridge ./charts --set mode=bridge --set service.tororport=443 --set service.tortransportport=4444
```

For chart values, persistence, NodePort behavior, and mode-specific examples, see [charts/README.md](/c:/Git/alpine-tor/charts/README.md).

## Notes

- Bridge mode requires both `ORPort` and `TransportPort`.
- Middle and exit modes require `ORPort`.
- Proxy mode requires `SOCKSPort`.
- For public relay operation, setting `ContactInfo` and `Nickname` is strongly recommended.
- For bridge and relay reachability behind NAT or load balancers, you may need to set `Address`.

## References

- [Tor Project relay setup](https://community.torproject.org/relay/setup/)
- [Tor Project bridge setup](https://community.torproject.org/relay/setup/bridge/)
- [Lyrebird](https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/lyrebird)
