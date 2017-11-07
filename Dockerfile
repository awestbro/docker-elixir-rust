FROM elixir:1.5.1

ENV RUST_VERSION=1.18.0
RUN echo "Elixir version: $(elixir -v)"

RUN apt-get update && \
    apt-get install \
       ca-certificates \
       curl \
       gcc \
       libc6-dev \
       -qqy \
       --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
ENV RUST_ARCHIVE="rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
ENV RUST_DOWNLOAD_URL="https://static.rust-lang.org/dist/$RUST_ARCHIVE"
RUN mkdir -p /rust \
    && cd /rust \
    && curl -fsOSL $RUST_DOWNLOAD_URL \
    && curl -s $RUST_DOWNLOAD_URL.sha256 | sha256sum -c - \
    && tar -C /rust -xzf $RUST_ARCHIVE --strip-components=1 \
    && rm $RUST_ARCHIVE \
    && ./install.sh

RUN echo "Rust version: ${RUST_VERSION}"

CMD ["iex"]