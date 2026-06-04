# Kubernetes Manifests

This directory contains raw Kubernetes manifests for running `alpine-tor` without Helm.

## Files

- [alpine-tor-proxy.deployment.yaml](/c:/Git/alpine-tor/manifests/alpine-tor-proxy.deployment.yaml)
  Runs Tor in `proxy` mode and exposes SOCKS on port `9050`.
- [alpine-tor-middle.deployment.yaml](/c:/Git/alpine-tor/manifests/alpine-tor-middle.deployment.yaml)
  Runs a non-exit relay in `middle` mode and exposes `ORPort` on `443`.
- [alpine-tor-bridge.deployment.yaml](/c:/Git/alpine-tor/manifests/alpine-tor-bridge.deployment.yaml)
  Runs a bridge in `bridge` mode and exposes `ORPort` on `443` plus obfs4 `TransportPort` on `4444`.
- [alpine-tor-exit.deployment.yaml](/c:/Git/alpine-tor/manifests/alpine-tor-exit.deployment.yaml)
  Runs an exit relay in `exit` mode and exposes `ORPort` on `443`.
- [alpine-tor-deployment.yaml](/c:/Git/alpine-tor/manifests/alpine-tor-deployment.yaml)
  Legacy generic proxy manifest. Functionally equivalent to the dedicated proxy manifest.

## Usage

Apply one manifest:

```bash
kubectl apply -f manifests/alpine-tor-proxy.deployment.yaml
```

Delete it again:

```bash
kubectl delete -f manifests/alpine-tor-proxy.deployment.yaml
```

Check the assigned NodePort:

```bash
kubectl get svc alpine-tor-proxy-service
```

For the proxy manifest, you can test the SOCKS endpoint with:

```bash
curl -x socks5h://<node-ip>:<node-port> -L http://ifconfig.me
```

## Notes

- These manifests are intentionally simple examples, not a full production deployment.
- They use `NodePort` services and fixed in-container ports.
- The bridge manifest requires both externally reachable ports.
- The manifests do not persist Tor state. If you want persistent identity keys and more configuration knobs, use the Helm chart in [charts/README.md](/c:/Git/alpine-tor/charts/README.md).
- For public relay operation, you will usually want to add `ContactInfo`, `Nickname`, and possibly `Address`.
