 #!/bin/sh
echo "Running jfwenisch/alpine-tor"
echo -e "Alpine Version: \c" && cat /etc/alpine-release
echo -e "Tor Version: \c" && tor --version
echo -e "OBFS4Proxy Version: \c" && obfs4proxy -version
echo "Searching for environment variable 'mode'"
if [ "$mode" = "exit" ]
then
   echo "Starting up as exit node"
   echo "ExitRelay 1" >> /etc/tor/torrc
   echo "DirPort $DirPort" >> /etc/tor/torrc
   echo "DirPortFrontPage /path/to/html/file" >> /etc/tor/torrc
elif [ "$mode" = "middle" ]
then
   echo "Starting up as middle / guard node"
   echo "ORPort $ORPort" >> /etc/tor/torrc
   echo "ExitRelay 0" >> /etc/tor/torrc
   echo "SocksPort 0" >> /etc/tor/torrc
   echo "ControlSocket 0" >> /etc/tor/torrc
elif [ "$mode" = "bridge" ]
then
  echo "Starting up as bridge node"
  echo "ORPort $ORPort" >> /etc/tor/torrc
  echo "BridgeRelay 1" >> /etc/tor/torrc
  echo "ServerTransportPlugin obfs4 exec /usr/local/bin/obfs4proxy" >> /etc/tor/torrc
  echo "ExtORPort auto" >> /etc/tor/torrc
elif [ "$mode" = "proxy" ]
then
  echo "Starting up as proxy"
  echo "SOCKSPort 0.0.0.0:$SOCKSPort" >> /etc/tor/torrc
else
   echo "No mode set. Please refer to the Readme.md on how to run. Exiting."
   exit;
fi
echo "Running tor -f /etc/tor/torrc"
tor -f /etc/tor/torrc
