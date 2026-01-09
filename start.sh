#!/bin/bash[ 2 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQESMno4_Nq76Hke8bse636P_foJpcBP7C6d9gumiYT6dAr9xqTdkB8zRo0k3tsD-jiSvzt_5GU2LJ3W64DENpcXXsmdMHijS5nPu2CE9kZMnkbsU8Rlo_tnwiMDKbAxBhaT4tPYrAGzapM=)][ 6 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQFPhW3iH9a2IWXiTQpILoXJC3x26hxWdvaZot4px38-aBLEO57rKC6WrMd98Cd3iNli4TfwEp8_JqCneVD9vLuPsjsfgKK18uxzpCaJZGA91Lxf4OAfR1SImJyqMGBxwEzGBN1ZfXTHDz-1PPWHD3gsXf1MUWTwE3x-xHhQFcWIDg9MyfSGkLdEZlIvcjBQqQ_V)][ 10 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQGYR8UU92LzqzVZyq4tGlQcya7AfPrnBmu_jZLv6Pnbte2WHRsdiBKgX86YL4r7P1lRmr-IDHVBNfb5WtIl7kwmqjx9DEgd_dmU5Xme6k28B9cU8z8mxQIAlORxxxy9MPcUjC-5xi_sQccnTZwJxiV6oizc6z5uSVmYsj9lSifG7Tx8GbJ84HTy0MRDdD69PdHv84Og_QL57sZPhQFBXnshZRTP8pLowdoX4Q==)][ 13 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH76tLZcbrX76QeCdt6kTi2s2RkAaKalJMCBGwuJgqKygCONz84iwEE9GhJOk_QQW4EiUzldBH_qWbnE0utplO8o7pb-ie4elR2xouFE7Nr3BPF18nV96GM1HsQVf19brkor6oA_P6ZSR_CksPoexHC5tBkpUnXoSAp6faEHGRnPH66EZk8Tk524T4=)][ 15 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHc5kCKJuA1sM36_VeoTFFvOa-1iqlHh0zeNk8IAZsaNgwcVuvqk5KKp9GH2Z4sa3IMuRMYBm50mCF8AmNPCy41TzY_y7_tAFyi-IyQxHX9E6380NRMkiy1Hilkr9-rZQmqqdzWf-Tlrpz6HMa4G68wLM_lfaT8YY757czvxFcMbU6_BMjjZsB5oD1U9Sbk8w==)][ 17 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHzPHzkQfSh9GnKRG9IlhiTR-jHnD2AhLkxyE5L14ZODpzOCCxwKdbF6sL7Pn0veNuV2o74AtcWRiUtvFZEOmq2iguulxmrDUeCl-2-upzPGUhRgbAvJ-W98CapfBkk4j7f_d-qAibNcBZhgCmuv7M72po2xdP8ot2aczdd9_RyVPIG7aZmrq6OBXvomJNNaEfV)]

# 1. Set up Jupyter Lab
# RunPod passes a random password in the variable RUNPOD_VOLUME_ID or similar, 
# but usually, we want to set a specific password or allow tokenless for private pods.
# This script sets a password if the env var JUPYTER_PASSWORD is provided, otherwise defaults to 'runpod'.

JUPYTER_PWD=${JUPYTER_PASSWORD:-runpod}

echo "Starting Jupyter Lab on port 8888..."
# Generate config if not exists
jupyter lab --generate-config
# Set the password (hashed)
echo "c.ServerApp.password = '$(python3 -c "from jupyter_server.auth import passwd; print(passwd('$JUPYTER_PWD'))")'" >> ~/.jupyter/jupyter_lab_config.py
echo "c.ServerApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_lab_config.py
echo "c.ServerApp.allow_origin = '*'" >> ~/.jupyter/jupyter_lab_config.py
echo "c.ServerApp.open_browser = False" >> ~/.jupyter/jupyter_lab_config.py

# Start Jupyter Lab in the background (&)
nohup jupyter lab --port=8888 --no-browser --allow-root --ip=0.0.0.0 > /var/log/jupyter.log 2>&1 &

# 2. Start Ostris AI Toolkit
echo "Starting AI Toolkit on port 8675..."
cd /app/ai-toolkit/ui

# The UI requires the python virtual environment or system python to be accessible.[ 4 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQF0Znb_uV0ohRfDT6fdRBIwyYU336X8y4tinlFiOCiy4WQ_PfzhRUz4iIS3lLRSXatQBiDl_mG1pp0YxZkwy8JzNf2a-R3-28LPq1k8Ccp-tG7_179U0D1ar_PxA7X1eQ==)]
# We ensure the python command maps to our installed python.
npm run start -- --host 0.0.0.0 --port 8675