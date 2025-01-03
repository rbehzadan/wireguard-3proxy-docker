# wireguard-3proxy-docker

Docker container combining WireGuard VPN with 3proxy to provide HTTP and SOCKS5 proxy services through an encrypted tunnel.

## Features

- WireGuard VPN for secure, encrypted tunneling
- HTTP proxy (port 3128)
- SOCKS5 proxy (port 1080)
- DNS resolution through VPN
- Container logs to stdout
- Multi-stage build for minimal image size

## Requirements

- Docker
- Docker Compose
- WireGuard configuration file (`wg0.conf`)

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/rbehzadan/wireguard-3proxy-docker.git
cd wireguard-3proxy-docker
```

2. Create WireGuard configuration file `wg0.conf`:
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

3. Start the container:
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

## Build from Source

```bash
git clone https://github.com/rbehzadan/wireguard-3proxy-docker.git
cd wireguard-3proxy-docker
docker build -t wireguard-3proxy:latest .
```

## Security Notes

- Container runs with privileged access (required for WireGuard)
- No authentication configured by default
- All traffic routed through VPN tunnel
- DNS queries resolved through VPN DNS servers

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License.
