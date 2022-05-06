FROM ubuntu:22.04
LABEL maintainer="Rob Whitby" url="https://github.com/robwhitby/shakedown"

RUN apt-get update \
    && apt-get install -y curl jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY sample-test.sh /usr/local/bin

COPY shakedown.sh /usr/local/bin

# run sample test
COPY sample-test.sh /tmp
RUN /tmp/sample-test.sh -u https://duckduckgo.com
