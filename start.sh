#!/bin/bash

# Exit on error
set -e

echo "=== Starting RunPod Container Services ==="

# 1. Set up Jupyter Lab
JUPYTER_PWD=${JUPYTER_PASSWORD:-runpod}

echo "Starting Jupyter Lab on port 8888..."

# Create .jupyter directory if it doesn't exist
mkdir -p ~/.jupyter

# Generate config if not exists
if [ ! -f ~/.jupyter/jupyter_lab_config.py ]; then
    jupyter lab --generate-config
fi

# Set the password (hashed) and configuration
cat >> ~/.jupyter/jupyter_lab_config.py << EOF
c.ServerApp.password = '$(python3 -c "from jupyter_server.auth import passwd; print(passwd('$JUPYTER_PWD'))")'
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.allow_origin = '*'
c.ServerApp.open_browser = False
c.ServerApp.port = 8888
c.ServerApp.allow_root = True
EOF

# Create log directory
mkdir -p /var/log

# Start Jupyter Lab in the background
nohup jupyter lab --config ~/.jupyter/jupyter_lab_config.py > /var/log/jupyter.log 2>&1 &

echo "✓ Jupyter Lab started on port 8888"
echo "  Password: $JUPYTER_PWD"
echo "  Logs: /var/log/jupyter.log"

# Wait a moment for Jupyter to start
sleep 3

# 2. Start Ostris AI Toolkit UI
echo "Starting AI Toolkit UI on port 8675..."
cd /app/ai-toolkit/ui

# Start the UI server in foreground (keeps container running)
echo "✓ AI Toolkit UI starting..."
exec npm run start -- --host 0.0.0.0 --port 8675
