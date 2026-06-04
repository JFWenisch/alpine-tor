# Helm Chart

This directory contains the Helm chart for deploying `alpine-tor` to Kubernetes.

Chart path from the repository root:

```bash
./charts
```

## What The Chart Does

The chart deploys the same container image as the root repository and supports the same four modes:

- `proxy`
- `middle`
- `bridge`
- `exit`

It also creates:

- a `ServiceAccount`
- a `PersistentVolume`
- a `PersistentVolumeClaim`
- a `Service`
- a `Deployment`

The chart is currently oriented toward simple single-node setups because it uses a local `hostPath`-backed persistent volume.

## Quickstart

Render the chart:

```bash
helm template alpine-tor ./charts
```

Install a proxy:

```bash
helm install alpine-tor-proxy ./charts --set mode=proxy
```

Install a bridge:

```bash
helm install alpine-tor-bridge ./charts --set mode=bridge --set service.tororport=443 --set service.tortransportport=4444
```

## Mode-Specific Behavior

The chart only exposes the ports relevant to the selected mode.

### Proxy

- Exposes `service.torsocksport`
- Requires `mode=proxy`

Example:

```bash
helm install alpine-tor-proxy ./charts --set mode=proxy --set service.torsocksport=9050
```

### Middle

- Exposes `service.tororport`
- Requires `mode=middle`

Example:

```bash
helm install alpine-tor-middle ./charts --set mode=middle --set service.tororport=443
```

### Bridge

- Exposes `service.tororport`
- Exposes `service.tortransportport`
- Requires `mode=bridge`

Example:

```bash
helm install alpine-tor-bridge ./charts --set mode=bridge --set service.tororport=443 --set service.tortransportport=4444
```

### Exit

- Exposes `service.tororport`
- Optionally exposes `service.tordirport`
- Requires `mode=exit`

Example:

```bash
helm install alpine-tor-exit ./charts --set mode=exit --set service.tororport=443
```

Optional `DirPort` example:

```bash
helm install alpine-tor-exit ./charts --set mode=exit --set service.tororport=443 --set service.tordirport=8080 --set service.tordirfrontpage=/etc/tor/notice.html
```

## Important Values

### Image

```yaml
image.repository
image.tag
image.pullPolicy
```

### Mode

```yaml
mode
```

### Persistence

```yaml
mountpath
```

This controls the `hostPath` used by the persistent volume.

### Service Ports

```yaml
service.tororport
service.tortransportport
service.torsocksport
service.tordirport
service.tordirfrontpage
```

### Relay Metadata

```yaml
service.torcontactinfo
service.tornickname
service.toraddress
service.tormyfamily
```

### Exit-Specific Options

```yaml
service.torexitpolicy
service.torreducedexitpolicy
service.exitnodes
```

### Additional Optional Values

```yaml
service.tordnsport
service.tordnslistenaddress
service.torhiddenservicedir
service.torhiddenserviceport
service.torpublishserverdescriptor
```

## NodePort Behavior

By default, Kubernetes assigns NodePorts automatically.

If you set:

```yaml
samenodeport: true
```

the chart uses the same port numbers for `nodePort` as for the service ports. That only works if those ports are inside your cluster's NodePort range, which is typically `30000-32767`.

Example:

```bash
helm install alpine-tor-bridge ./charts --set mode=bridge --set samenodeport=true --set service.tororport=30443 --set service.tortransportport=30444
```

## Caveats

- The chart is not tuned for multi-node persistence.
- Bridge mode requires both ports to be externally reachable.
- For public relays and bridges, you should usually set `service.torcontactinfo` and `service.tornickname`.
- In NAT or load balancer environments, you may need `service.toraddress`.

## Related Docs

- Root overview: [README.md](/c:/Git/alpine-tor/README.md)
- Raw Kubernetes manifests: [manifests/README.md](/c:/Git/alpine-tor/manifests/README.md)
