FROM golang:1.23-alpine as golang-base
FROM eclipse-temurin:11-jre-alpine as java-base
FROM alpine:latest as final

RUN apk add --no-cache \
    bash \
    ca-certificates \
    git \
    openssh-client

COPY --from=java-base /opt/java /opt/java
COPY --from=golang-base /usr/local/go /usr/local/go

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="/usr/local/go/bin:$JAVA_HOME/bin:$PATH"

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

CMD ["bash"]