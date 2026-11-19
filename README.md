# Komodo Periphery (Multi-Arch)

Automated multi-arch Docker image for [Komodo Periphery](https://github.com/moghtech/komodo) with native `linux/arm/v7` support alongside official `linux/amd64` and `linux/arm64` builds.

## Image

```
ghcr.io/potatoptt/komodo-periphery:latest
ghcr.io/potatoptt/komodo-periphery:<version>
```

## Supported Platforms

| Platform | Source |
|---|---|
| `linux/amd64` | Official `ghcr.io/moghtech/komodo-periphery` manifest |
| `linux/arm64` | Official `ghcr.io/moghtech/komodo-periphery` manifest |
| `linux/arm/v7` | Cross-compiled from official `moghtech/komodo` release tags (`debian:trixie-slim` + Docker CLI/Compose) |

## How it works

A scheduled GitHub Actions workflow checks for new `moghtech/komodo` releases twice daily:
1. Verifies the official upstream `amd64` and `arm64` manifests are published.
2. Cross-compiles `komodo_periphery` for `armv7-unknown-linux-gnueabihf` using the matching Rust toolchain on Debian Trixie.
3. Builds and smoke-tests the `linux/arm/v7` container under QEMU (`ldd`, `periphery --help`, `docker compose version`).
4. Stitches official `amd64` + `arm64` with the `arm/v7` build into a single multi-arch OCI manifest via `docker buildx imagetools create`.
