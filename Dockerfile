FROM ubuntu:xenial

ENV GOLANG_VERSION 1.7rc5
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 53393c132223415c30ef877cb5c900d989f8a953e864e1119aeaedbca1918144
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# gcc for cgo
RUN apt-get update && apt-get -y upgrade && \ 
    apt-get install -y curl && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
    cd "$GOPATH/src" && \
    curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz && \
    echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - && \
    tar -C /usr/local -xzf golang.tar.gz && \
    rm golang.tar.gz && \
    apt-get purge -y curl && \
    apt-get -y clean && apt-get -y autoclean && apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $GOPATH
