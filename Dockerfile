FROM alpine:latest
LABEL maintainer="info@jfwenisch.com"
RUN apk update
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
RUN git clone https://git.torproject.org/tor.git
RUN cd tor && ./autogen.sh
RUN cd tor && ./configure --disable-asciidoc
RUN cd tor && make
RUN cd tor && make install
RUN rm -rf /var/cache/apk/*
EXPOSE 9050
COPY torrc /etc/tor/torrc
ENTRYPOINT [ "tor" ]
CMD [ "-f", "/etc/tor/torrc" ]