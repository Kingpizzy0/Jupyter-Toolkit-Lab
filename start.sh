#!/bin/bash

# Exit on error
set -e

echo "=== Starting Jupyter Toolkit Lab Services ==="

# Configuration
JUPYTER_PORT=${JUPYTER_PORT:-8888}
AI_TOOLKIT_PORT=${AI_TOOLKIT_PORT:-8675}
COMFYUI_PORT=${COMFYUI_PORT:-8188}
LOG_DIR="/var/log"

# Create log directory
mkdir -p "$LOG_DIR"

# 1. Set up Jupyter Lab
echo "[INFO] Configuring Jupyter Lab on port $JUPYTER_PORT..."

# Create .jupyter directory if it doesn't exist
mkdir -p ~/.jupyter

# Generate config if not exists
if [ ! -f ~/.jupyter/jupyter_lab_config.py ]; then
    jupyter lab --generate-config
fi

# Set the password (hashed) and configuration
cat >> ~/.jupyter/jupyter_lab_config.py << EOF
c.ServerApp.token = ''
c.ServerApp.password = ''
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.allow_origin = '*'
c.ServerApp.open_browser = False
c.ServerApp.port = $JUPYTER_PORT
c.ServerApp.allow_root = True
EOF

# Start Jupyter Lab in the background
echo "[INFO] Starting Jupyter Lab..."
nohup jupyter lab --config ~/.jupyter/jupyter_lab_config.py > "$LOG_DIR/jupyter.log" 2>&1 &
JUPYTER_PID=$!

# Verify Jupyter started
sleep 3
if ps -p $JUPYTER_PID > /dev/null; then
    echo "[OK] Jupyter Lab started successfully on port $JUPYTER_PORT"
    echo "      Logs: $LOG_DIR/jupyter.log"
    echo "      Access: No password required"
else
    echo "[ERROR] Jupyter Lab failed to start. Check logs at $LOG_DIR/jupyter.log"
    cat "$LOG_DIR/jupyter.log"
    exit 1
fi

# 2. Start ComfyUI
echo "[INFO] Starting ComfyUI on port $COMFYUI_PORT..."
cd /app/ComfyUI

nohup python main.py --listen 0.0.0.0 --port "$COMFYUI_PORT" > "$LOG_DIR/comfyui.log" 2>&1 &
COMFYUI_PID=$!

# Verify ComfyUI started
sleep 5
if ps -p $COMFYUI_PID > /dev/null; then
    echo "[OK] ComfyUI started successfully on port $COMFYUI_PORT"
    echo "      Logs: $LOG_DIR/comfyui.log"
else
    echo "[ERROR] ComfyUI failed to start. Check logs at $LOG_DIR/comfyui.log"
    cat "$LOG_DIR/comfyui.log"
    exit 1
fi

# 3. Start Ostris AI Toolkit UI
echo "[INFO] Starting AI Toolkit UI on port $AI_TOOLKIT_PORT..."
cd /app/ai-toolkit/ui

# Start the UI server in foreground (keeps container running)
echo "[OK] Launching AI Toolkit UI..."

# Error handling for npm start
if ! exec npm run start -- --host 0.0.0.0 --port "$AI_TOOLKIT_PORT"; then
    echo "[ERROR] AI Toolkit UI failed to start"
    exit 1
fi
