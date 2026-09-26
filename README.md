# ManubisGuard Node

AmneziaWG-enabled ManubisGuard Node from the `feature/amnezia-wg` branch.

## One-command installation

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ManubisGuard/ManubisGuard-Node/feature/amnezia-wg/install-manubisguard-node.sh)" @ install
```

The installer follows the interactive PasarGuard Node installation workflow. A normal interactive install asks for the Node service port, TLS/certificate mode, API key, and gRPC/REST transport. Use `-y` only when you intentionally want the non-interactive defaults.

After installation, the same workflow installs the `manubis-node` host command for lifecycle management.

```bash
sudo manubis-node status
sudo manubis-node restart
sudo manubis-node logs
```

## Multi-Core on one Node

A single ManubisGuard Node can be assigned to multiple Core configurations from the Node settings in the ManubisGuard Panel. Select the desired Core configurations with the checkboxes next to the Node connection settings.

- Multiple WireGuard/AmneziaWG Core instances can run concurrently on one Node.
- Xray uses one process for all Xray inbounds, so only one Xray Core configuration can be selected per Node.
- Existing Nodes that only have the legacy `core_config_id` remain compatible.
- Adding another Core uses additive synchronization so already-running compatible Cores are not unnecessarily stopped.

## Status and uninstall

```bash
sudo manubis-node status
sudo manubis-node uninstall
```

Persistent data remains under the Node data directory configured by the installer.

## Matching Panel

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ManubisGuard/ManubisGuard-Panel/feature/amnezia-wg/install-manubisguard.sh)" @ install --database timescaledb
```

## Manubis CLI

The Node fork now ships the full upstream-style Node CLI under the **manubis** command. The command surface is adapted for ManubisGuard while preserving the existing Node runtime layout and compatibility.

```bash
sudo manubis status
sudo manubis restart
sudo manubis logs
sudo manubis update
sudo manubis core-update --version latest
sudo manubis geofiles --iran
sudo manubis renew-cert
```

### CLI command set

| Command | Purpose |
|---|---|
| `install` | Install or reinstall a Node instance |
| `update` | Update the Node deployment and optionally its service |
| `uninstall` | Remove the Node instance |
| `up` / `down` | Start or stop the Node stack |
| `restart` | Restart the Node stack, with log/service controls |
| `status` | Show Node, port, certificate and Core status |
| `logs` | Follow Node container logs |
| `core-update` | Install or switch Xray-core |
| `geofiles` | Update regional geoip/geosite assets |
| `renew-cert` | Regenerate the Node TLS certificate |
| `edit` / `edit-env` | Edit Compose or environment configuration |
| `install-script` / `uninstall-script` | Install/remove the global `manubis` CLI |
| `completion` | Install Bash/Zsh completion |
| `version-script` / `script-version` | Show CLI version and commit |
| `service-install` | Install the Node systemd service |
| `service-uninstall` | Remove the Node systemd service |
| `service-start` / `service-stop` | Start or stop the systemd service |
| `service-restart` | Restart the systemd service |
| `service-status` | Show systemd service status |
| `service-logs` | Follow or inspect service logs |
| `service-update` | Update the service helper binary |

Global options include `-y/--yes` and `--name`. Install also supports version selection, REST/gRPC selection, service/API ports, API key, TLS certificate/key, SAN entries, self-signed certificates, service installation, and override mode.

### CLI installation

```bash
curl -fsSL https://raw.githubusercontent.com/ManubisGuard/ManubisGuard-Node/feature/amnezia-wg/install.sh | sudo bash -s -- install
```

After installation:

```bash
sudo manubis status
```

The CLI is intentionally named `manubis`. Existing Node deployments keep their current `/opt/manubisguard-node` and `/var/lib/pg-node` runtime paths unless the operator explicitly selects another instance configuration.
