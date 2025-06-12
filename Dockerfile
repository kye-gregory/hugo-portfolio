# Setup System
FROM ubuntu:22.04
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl ca-certificates unzip git gcc g++ clang \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Go
ENV GOBIN=/usr/local/bin
RUN curl -LO https://go.dev/dl/go1.24.3.linux-amd64.tar.gz \
    && tar xzf go1.24.3.linux-amd64.tar.gz \
    && mv go /opt \
    && ln -s /opt/go/bin/go /usr/local/bin/go \
    && rm go1.24.3.linux-amd64.tar.gz

# Install Hugo
RUN go install -tags extended github.com/gohugoio/hugo@v0.147.3

# Add Non-Root User
RUN useradd -ms /bin/bash dev
USER dev
WORKDIR /home/dev

# Define Entry
CMD ["sleep", "infinity"]
