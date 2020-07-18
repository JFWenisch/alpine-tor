# alpine-tor-docker
Alpine based [Tor](https://www.torproject.org/) docker container building [Tor](https://www.torproject.org/) from src and exposing Socks5 Port per default when running.

## Installation
### Pull docker image from dockerhub

```
docker pull jfwenisch/alpine-tor
```
### Build docker image manually

```
git pull https://github.com/JFWenisch/alpine-tor-docker.git
docker build -t jfwenisch/alpine-tor .
```

## Run container

```
docker run -p 9050:9050 jfwenisch/alpine-tor
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