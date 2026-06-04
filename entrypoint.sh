#!/bin/sh

append_config() {
  printf '%s\n' "$1" >> /etc/tor/torrc
}

append_if_set() {
  name="$1"
  value="$2"
  if [ -n "$value" ]; then
    append_config "$name $value"
  fi
}

require_env() {
  name="$1"
  value="$2"
  if [ -z "$value" ]; then
    echo "Required environment variable '$name' is not set for mode '$mode'."
    exit 1
  fi
}

transport_port="${TransportPort:-$PTPort}"

echo "Running jfwenisch/alpine-tor"
echo -e "Alpine Version: \c" && cat /etc/alpine-release
echo -e "Tor Version: \c" && tor --version
echo -e "Lyrebird Version: \c" && lyrebird -version
echo "Searching for environment variable 'mode'"

append_config "DataDirectory /tor"
append_if_set "ContactInfo" "$ContactInfo"
append_if_set "Nickname" "$Nickname"

case "$mode" in
  exit)
    echo "Starting up as exit node"
    require_env "ORPort" "$ORPort"
    append_config "ORPort 0.0.0.0:$ORPort"
    append_config "ExitRelay 1"
    append_config "SocksPort 0"
    if [ -n "$DirPort" ]; then
      append_config "DirPort 0.0.0.0:$DirPort"
    fi
    append_if_set "DirPortFrontPage" "$DirPortFrontPage"
    ;;
  middle)
    echo "Starting up as middle / guard node"
    require_env "ORPort" "$ORPort"
    append_config "ORPort 0.0.0.0:$ORPort"
    append_config "ExitRelay 0"
    append_config "SocksPort 0"
    ;;
  bridge)
    echo "Starting up as bridge node"
    require_env "ORPort" "$ORPort"
    require_env "TransportPort or PTPort" "$transport_port"
    append_config "ORPort 0.0.0.0:$ORPort"
    append_config "BridgeRelay 1"
    append_config "SocksPort 0"
    append_config "ServerTransportPlugin obfs4 exec /usr/bin/lyrebird"
    append_config "ServerTransportListenAddr obfs4 0.0.0.0:$transport_port"
    append_config "ExtORPort auto"
    if [ -n "$MyFamily" ]; then
      echo "Ignoring MyFamily for bridge mode, as Tor bridges should not publish a family."
    fi
    ;;
  proxy)
    echo "Starting up as proxy"
    require_env "SOCKSPort" "$SOCKSPort"
    append_config "SocksPort 0.0.0.0:$SOCKSPort"
    ;;
  *)
    echo "No valid mode set. Please refer to the README.md on how to run this image."
    exit 1
    ;;
esac

append_if_set "DNSPort" "$DNSPort"
append_if_set "DNSListenAddress" "$DNSListenAddress"
if [ "$mode" != "bridge" ]; then
  append_if_set "MyFamily" "$MyFamily"
fi
append_if_set "HiddenServiceDir" "$HiddenServiceDir"
append_if_set "HiddenServicePort" "$HiddenServicePort"
append_if_set "ExitNodes" "$ExitNodes"
append_if_set "ReducedExitPolicy" "$ReducedExitPolicy"
append_if_set "ExitPolicy" "$ExitPolicy"
append_if_set "PublishServerDescriptor" "$PublishServerDescriptor"
append_if_set "Address" "$Address"

echo "Running tor -f /etc/tor/torrc"
exec tor -f /etc/tor/torrc
