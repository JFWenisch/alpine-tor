
# alpine-tor-helm
Helm chart running [alpine-tor-docker](https://github.com/JFWenisch/alpine-tor-docker) container allowing to be configured as middle(guard)- , bridge- , exit-relay or as proxy exposing only the socks5 Port per default when running. Prepared to be run on a single node cluster due to persistence via local mountpath. 

  
## Add Repository
The packaged chart is hosted via github pages and can be found under https://github.com/JFWenisch/charts/tree/master/alpine-tor. To add the chart repository run

```
helm repo add jfwenisch https://jfwenisch.github.io/charts
helm repo update
```

Alternatively, you can manually fetch the chart
```
git clone https://github.com/JFWenisch/alpine-tor-helm.git
cd alpine-tor-helm
```

## General usage

Test deployment via helm repo

```
helm install --dry-run --debug --generate-name jfwenisch/alpine-tor

```

If you pulled the repository and want to deploy it from src run the following command from within the alpine-tor-helm directory

```
helm install --dry-run --debug --generate-name .

```


### Defining the mode
Supported modes: proxy,exit,middle,bridge. For more information on supported modes pls refer to the [alpine-tor-docker readme](https://github.com/JFWenisch/alpine-tor-docker) and the official [tor-relay-guide](https://trac.torproject.org/projects/tor/wiki/TorRelayGuide)
The different modes these can be set via --set mode=$value. If no mode is specified the default value "mode:proxy" will be used.

```
helm install --dry-run --debug --generate-name --set mode=bridge ./chart

```

### Persistence / Defining mountpath
The chart inherits a 100M volume and volumeclaim that enables persistence via a local mountpath. The mountpath is per default set to /tmp an can be overriden by using --set mountpath=/mnt/...

```
helm install --dry-run --debug --generate-name --set mode=bridge -set mountpath=/media/raid/kubernetes/torvolume1 ./chart

```

### Defining ports
Based on the chosen mode, different ports are set within the torrc. Which options are set can be viewed within the entrypoint sh. Per default port 80 is set as DirPort. port 443 is set as ORPort and Port 9050 is set as socksport. These values can be overwritten as

```
helm install --dry-run --debug --generate-name --set mode=exit --set service.tordirport=8080 ./chart
helm install --dry-run --debug --generate-name --set mode=middle --set service.tororport=4443 ./chart
helm install --dry-run --debug --generate-name --set mode=bridge --set service.tororport=4443 ./chart
helm install --dry-run --debug --generate-name --set mode=proxy --set service.torsocksport=10050 ./chart

```
### Exposing ports as NodePort
Per default the service makes the set ports available via nodePorts and automatically assigns a port within the kubernetes nodePort rang (default 30000 - 32767). As tor is making a self check on the set ports and no router is in front of the kubernetes node which might be used to map to the automatically assigned nodePort, fixed values for the nodeport can be set by specifying '--set samenodeport=true'. If set to true, the same ports that are specified as tordirport,tororport and torsocksport  will be used as nodeport.

Warning: If set to true, the specified ports have to be within the kubernetes nodePort rang (default 30000 - 32767)

```
helm install --dry-run --debug --generate-name --set mode=mide --set samenodeport=true --set service.torsocksport=30050 --set service.tororport=30443 --set service.tordirport=30080 ./chart

```

### Additional configuration


```
--set service.torcontactinfo="J.-Fabian Wenisch <info AT jfwenisch dot com>" 
--set service.tornickname="alpine-tor" 
--set service.tordnsport=""
--set service.tordnslistenaddress=""
--set service.tormyfamily=""
--set service.torhiddenservicedir=""
--set service.torhiddenserviceport=""
```

### Quickstart
```
helm install alpine-tor-middle --set mode=middle --set samenodeport=true --set service.torsocksport="30050" --set service.tororport="30051" --set service.tordirport="30052" --set mountpath=/tmp ./chart
```


## Further information

[alpine-tor-docker](https://github.com/JFWenisch/alpine-tor-docker)

[Tor Project](https://www.torproject.org/)

[Alpine Linux ](https://alpinelinux.org/)

[obfs4 - The obfourscator](https://gitlab.com/yawning/obfs4)
 

 
  



