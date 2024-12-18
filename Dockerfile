FROM alpine:latest
LABEL maintainer="info@jfwenisch.com"
ARG TORVERSION
RUN if [[ -z "$TORVERSION" ]] ; then echo Build argument "TORVERSION" not provided. To build a specific version run with --build-arg TORVERSION=0.4.4.6 ; else echo Build argument torversion is $TORVERSION ; fi
#Init


RUN apk update
# Add required build utitlities
RUN apk --no-cache add --update \
        gnupg \
        build-base \
        ca-certificates \
        gcc \
        gnupg \
        wget \
        git \
        libcap \
        libevent \
        libevent-dev \
        libressl \
        libressl-dev \
        openssl \
        xz-libs \
        xz-dev \
        zlib \
        zlib-dev \
        zstd \
        zstd-libs \
        zstd-dev \
        automake \
        autoconf
#Add obfs4proxy for usage as bridge
RUN apk add --no-cache lyrebird=0.5.0-r0   --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
# Create a group and user
#RUN addgroup -S torusergrp && adduser -S toruser -G torusergrp


#Build
################## remove build from repo, and make from tarball
#RUN git clone https://gitlab.torproject.org/tpo/core/tor.git
#Get the latest tag from remote not containing 'alpha' or 'dev' or 'rc' and switch to it (git checkout $release). 
#RUN if [[ -z "$TORVERSION" ]] ; then export TORVERSION=$(git ls-remote --tags --sort="v:refname" https://git.torproject.org/tor.git | grep -v 'rc'| grep -v 'alpha'| grep -v 'dev'| tail -n1| sed  's/.*\///; s/\^{}//') &&  cd tor && git checkout $TORVERSION; else echo Build argument torversion is $TORVERSION &&  cd tor && git checkout $TORVERSION; fi
#RUN cd tor && ./autogen.sh
#RUN cd tor && ./configure --disable-asciidoc
#RUN cd tor && make
#RUN cd tor && make install
#RUN rm -rf /tor
###########################################################
RUN if [[ -z "$TORVERSION" ]] ; then export TORVERSION=$(git ls-remote --tags --sort="v:refname" https://git.torproject.org/tor.git | grep -v 'rc'| grep -v 'alpha'| grep -v 'dev'| tail -n1| sed  's/.*\///; s/\^{}//'); else echo Build argument torversion is $TORVERSION; fi

RUN wget --no-verbose https://www.torproject.org/dist/ $TORVERSION.tar.gz
RUN wget --no-verbose https://www.torproject.org/dist/${TOR_VERSION}.tar.gz.asc
RUN gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys \
  0x6AFEE6D49E92B601 \
  0x28988BF5 \
  0x19F78451 && 
RUN gpg --verify tor-${TORVERSION}.tar.gz.asc && export "CFLAGS=-Wno-cpp" && tar -zxf ${TORVERSION}.tar.gz
RUN cd ${TORVERSION} && \
./configure \
  --disable-gcc-warnings-advisory \
  --localstatedir=/var \
  --prefix=/usr \
  --silent \
  --sysconfdir=/etc
RUN make
RUN make test

RUN rm -rf /var/cache/apk/*
COPY torrc /etc/tor/torrc

COPY entrypoint.sh /entrypoint.sh
#Permission for tor-user
#RUN chown -R toruser /etc/tor/torrc
RUN chmod +x /entrypoint.sh
#RUN mkdir /tor
#RUN chown -R toruser /tor


# Tell docker that all future commands should run as the appuser user
#USER toruser

ENTRYPOINT [ "/bin/sh" , "entrypoint.sh" ]
