FROM debian:trixie-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      curl \
      wget \
      ca-certificates \
      openssl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
      > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      docker-ce-cli \
      docker-buildx-plugin \
      docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

COPY periphery /usr/local/bin/periphery
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/periphery /usr/local/bin/entrypoint.sh

EXPOSE 8120

ENV PERIPHERY_CONFIG_PATHS="/config"
ENV PERIPHERY_PRIVATE_KEY="file:/config/keys/periphery.key"

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "periphery" ]

LABEL komodo.skip="true"
LABEL org.opencontainers.image.source="https://github.com/PotatoPTT/komodo-periphery"
LABEL org.opencontainers.image.description="Komodo Periphery multi-arch (linux/amd64, linux/arm64, linux/arm/v7)"
LABEL org.opencontainers.image.licenses="GPL-3.0"
