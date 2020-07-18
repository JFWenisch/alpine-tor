# tor-docker
Alpine based [Tor](https://www.torproject.org/) docker container building [Tor](https://www.torproject.org/) from src and exposing Socks5 Port per default when running.

## Build docker image

```
docker build -t jfwenisch/alpine-tor-docker .
```

## Run container

```
docker run -p 9050:9050 jfwenisch/alpine-tor-docker
```

## Testing socks5 proxy

Start by getting your real external ip
```
curl -L https://ifconfig.me
```

Compare it with the external IP under use of the tor socks5 proxy
```
curl -x socks5h://localhost:9050 -L http://ifconfig.me
```