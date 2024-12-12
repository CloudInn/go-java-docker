FROM golang:1.23-bullseye as golang-base

FROM gcr.io/distroless/java11-debian11:nonroot as java-base

FROM debian:bullseye-slim as final

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    git \ 
    && rm -rf /var/lib/apt/lists/*

COPY --from=java-base /usr/lib/jvm /usr/lib/jvm
COPY --from=golang-base /usr/local/go /usr/local/go

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin:/usr/local/go/bin

CMD ["bash"]