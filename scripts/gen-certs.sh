#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CERT_DIR="$ROOT/apache/certs"
mkdir -p "$CERT_DIR"

if command -v mkcert >/dev/null 2>&1; then
  echo "Using mkcert"
  mkcert -cert-file "$CERT_DIR/lab.pem" -key-file "$CERT_DIR/lab-key.pem" localhost 127.0.0.1
else
  echo "mkcert not found; generating self-signed cert"
  openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout "$CERT_DIR/lab-key.pem" \
    -out "$CERT_DIR/lab.pem" \
    -subj "/CN=localhost"
fi

chmod 644 "$CERT_DIR/lab.pem"
chmod 600 "$CERT_DIR/lab-key.pem"
echo "Wrote $CERT_DIR/lab.pem and lab-key.pem"
