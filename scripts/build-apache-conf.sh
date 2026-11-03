#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/apache/conf/httpd.conf"

# Pull stock config from the image, then append our vhost include
docker run --rm httpd:2.4 cat /usr/local/apache2/conf/httpd.conf > "$OUT"

# Uncomment includes if commented (httpd image varies by tag)
# Append our lab vhost
cat >> "$OUT" <<'EOF'

# --- lab overlay ---
Include conf/extra/lab-ssl.conf
EOF

cp "$ROOT/apache/conf/lab-ssl.conf" "$ROOT/apache/conf/lab-ssl.conf"
echo "Wrote $OUT (stock + Include conf/extra/lab-ssl.conf)"
