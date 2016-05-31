FROM golang:1.6-alpine

RUN apk add --update git gcc musl-dev \
    && cd $GOPATH \
    && mkdir -p src/github.com/compose pkg \
    && cd src/github.com/compose \
    && git clone https://github.com/albertzak/transporter \
    && cd transporter \
    && go get -a ./cmd/... \
    && go build -a ./cmd/... \
    && apk del git gcc musl-dev \
    && rm -rf /var/cache/apk/*

RUN mkdir /transporter

COPY entry.sh /transporter/entry.sh

RUN chmod +x /transporter/entry.sh

ENTRYPOINT /transporter/entry.sh
