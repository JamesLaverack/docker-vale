FROM alpine:3.7
MAINTAINER James Laverack <james@jameslaverack.com>

# Asciidoctor packages
RUN apk update && \
    apk add asciidoctor

# Download
ARG valeVersion=0.11.0
RUN apk add wget ca-certificates && \
    wget -O vale.tgz https://github.com/ValeLint/vale/releases/download/v${valeVersion}/vale_${valeVersion}_Linux_64-bit.tar.gz

# Check
ARG valeSha256=4177088725ebb079ef78fc1ae8f0870c52c6f5d2259ce3feb06bdc19d430441f
RUN echo "$valeSha256  vale.tgz" | sha256sum -c -

# Install
ARG installDirectory=/usr/local/vale
RUN mkdir -p $installDirectory && \
    tar -zxvf vale.tgz --directory $installDirectory && \
    ln -s $installDirectory/vale /bin/vale && \
    rm -rf /var/cache

ENTRYPOINT [ "vale" ]
