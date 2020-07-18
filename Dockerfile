FROM alpine:latest
RUN apk update
RUN apk add tor --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/main 
RUN rm -rf /var/cache/apk/*
EXPOSE 9050
COPY torrc /etc/tor/torrc
RUN chown -R tor /etc/tor
USER tor
ENTRYPOINT [ "tor" ]
CMD [ "-f", "/etc/tor/torrc" ]