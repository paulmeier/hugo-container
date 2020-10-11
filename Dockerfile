FROM alpine:3.12@sha256:4716d67546215299bf023fd80cc9d7e67f4bdc006a360727fd0b0b44512c45db

RUN apk add --update \
    git \
    asciidoctor \
    libc6-compat \
    libstdc++ \
    openssl \
    ca-certificates \
    wget &&\
    update-ca-certificates

ENV HUGO_VERSION=0.76.3
ENV HUGO_TYPE=_extended
ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}
ENV HUGO=/usr/local/sbin/hugo
RUN echo 'nameserver 8.8.8.8' > /etc/resolv.conf && \
    wget -O - https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-64bit.tar.gz | tar -xz -C /tmp \
        && mkdir -p /usr/local/sbin \
        && mv /tmp/hugo /usr/local/sbin/hugo \
        && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
        && rm -rf /tmp/LICENSE.md \
        && rm -rf /tmp/README.md

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "/bin/sh" ]
