FROM alpine:latest
#Init
EXPOSE 9050
LABEL maintainer="info@jfwenisch.com"
RUN apk update
# Add required build utitlities
RUN apk --no-cache add --update \
        gnupg \
        build-base \
        gcc \
        wget \
        git \
        libevent \
        libevent-dev \
        libressl \
        libressl-dev \
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
RUN apk add --no-cache obfs4proxy=0.0.11-r2   --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing
# Create a group and user
#RUN addgroup -S torusergrp && adduser -S toruser -G torusergrp


#Build
RUN git clone https://git.torproject.org/tor.git
#Get the latest tag from remote not containing 'alpha' or 'dev' or 'rc' and switch to it (git checkout $release). 
RUN export release=$(git ls-remote --tags --sort="v:refname" https://git.torproject.org/tor.git | grep -v 'rc'| grep -v 'alpha'| grep -v 'dev'| tail -n1| sed  's/.*\///; s/\^{}//');echo $release;cd tor && git checkout $release;
RUN cd tor && ./autogen.sh
RUN cd tor && ./configure --disable-asciidoc
RUN cd tor && make
RUN cd tor && make install
RUN rm -rf /var/cache/apk/*
RUN rm -rf /tor


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
