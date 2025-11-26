#!/bin/bash
set -e

echo "=== Running provisioning ==="
/provisioning.sh

if [ $? -ne 0 ]; then
    echo "ERROR: Provisioning failed!"
    exit 1
fi

echo "=== Provisioning complete! ==="
echo "=== Starting Forge WebUI ==="

if [ ! -f /app/ui-config.json.backup ]; then
    cp /app/ui-config.json /app/ui-config.json.backup
else
    cp /app/ui-config.json.backup /app/ui-config.json
fi

TARGET_PORT=${PORT:-7870}
INTERNAL_PORT=7860

export GRADIO_SERVER_NAME="127.0.0.1"
export GRADIO_SERVER_PORT="${INTERNAL_PORT}"

LAUNCH_ARGS="--listen --port ${INTERNAL_PORT} --api --enable-insecure-extension-access --skip-python-version-check --ui-settings-file /app/ui-settings.json --ui-config-file /app/ui-config.json"

echo "=== Starting socat IPv6 proxy [::]:${TARGET_PORT} -> 127.0.0.1:${INTERNAL_PORT} ==="
socat TCP6-LISTEN:${TARGET_PORT},fork,reuseaddr,ipv6only=0 TCP4:127.0.0.1:${INTERNAL_PORT} &
SOCAT_PID=$!
sleep 2

echo "=== Starting Forge WebUI on 127.0.0.1:${INTERNAL_PORT} ==="

python3 launch.py $LAUNCH_ARGS