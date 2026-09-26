#!/usr/bin/env bash
set -Eeuo pipefail
REPO="${MANUBISGUARD_NODE_REPO:-https://raw.githubusercontent.com/ManubisGuard/ManubisGuard-Node/feature/amnezia-wg/manubis.sh}"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl -fsSL "$REPO" -o "$tmp"
export MANUBISGUARD_NODE_BRANCH="${MANUBISGUARD_NODE_BRANCH:-feature/amnezia-wg}"
chmod +x "$tmp"
exec "$tmp" "$@"
