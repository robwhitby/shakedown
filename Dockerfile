FROM bash:5
LABEL maintainer="Rob Whitby" url="https://github.com/robwhitby/shakedown"

RUN apk add --no-cache curl
COPY shakedown.sh /usr/local/bin/shakedown.sh
