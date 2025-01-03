# WireGuard with 3proxy Docker Image

This Docker image combines WireGuard VPN with 3proxy to provide both HTTP and SOCKS5 proxy services through a VPN tunnel.

## Features

- WireGuard VPN connectivity
- HTTP proxy (port 3128)
- SOCKS5 proxy (port 1080)
- DNS resolution through VPN
- Logging to stdout for container monitoring

## Prerequisites

- Docker
- Docker Compose
- WireGuard configuration file (`wg0.conf`)

## Usage

1. Prepare your WireGuard configuration file `wg0.conf`. Example:
```ini
[Interface]
PrivateKey = your_private_key
Address = your_ip_address
DNS = 1.1.1.1, 8.8.8.8

[Peer]
PublicKey = peer_public_key
AllowedIPs = 0.0.0.0/0
Endpoint = peer_endpoint:port
```

2. Run with Docker Compose:
```bash
docker compose up -d
```

## Docker Compose Configuration

```yaml
services:
  wireguard:
    image: rbehzadan/wireguard-3proxy
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    devices:
      - /dev/net/tun
    privileged: true
    volumes:
      - ./wg0.conf:/etc/wireguard/wg0.conf
    ports:
      - "3128:3128"
      - "1080:1080"
```

## Configuration

The image uses the following default ports:
- HTTP Proxy: 3128
- SOCKS5 Proxy: 1080

### Environment Variables
None required.

### Volumes
Mount your WireGuard configuration:
```yaml
volumes:
  - ./wg0.conf:/etc/wireguard/wg0.conf
```

### Required Capabilities
```yaml
cap_add:
  - NET_ADMIN
  - SYS_MODULE
devices:
  - /dev/net/tun
privileged: true
```

## Security Considerations

- The container runs in privileged mode due to WireGuard requirements
- No authentication is configured by default
- All traffic is routed through the VPN tunnel
- DNS queries are resolved through the VPN's DNS servers

## Building

```bash
docker build -t rbehzadan/wireguard-3proxy:tag .
```

## License

This project is licensed under the MIT License.

## Similar Projects
[linuxserver/wireguard](https://hub.docker.com/r/linuxserver/wireguard) - A robust WireGuard container that focuses on VPN functionality. Our project extends this concept by adding HTTP and SOCKS5 proxy capabilities through 3proxy.
