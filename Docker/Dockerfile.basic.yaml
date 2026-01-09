# Base image with CUDA 12.4.1
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive[ 13 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH76tLZcbrX76QeCdt6kTi2s2RkAaKalJMCBGwuJgqKygCONz84iwEE9GhJOk_QQW4EiUzldBH_qWbnE0utplO8o7pb-ie4elR2xouFE7Nr3BPF18nV96GM1HsQVf19brkor6oA_P6ZSR_CksPoexHC5tBkpUnXoSAp6faEHGRnPH66EZk8Tk524T4=)][ 15 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHc5kCKJuA1sM36_VeoTFFvOa-1iqlHh0zeNk8IAZsaNgwcVuvqk5KKp9GH2Z4sa3IMuRMYBm50mCF8AmNPCy41TzY_y7_tAFyi-IyQxHX9E6380NRMkiy1Hilkr9-rZQmqqdzWf-Tlrpz6HMa4G68wLM_lfaT8YY757czvxFcMbU6_BMjjZsB5oD1U9Sbk8w==)]

# Install System Dependencies & Python 3.11
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3-pip \
    git \
    curl \
    wget \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.11 as default
RUN ln -s /usr/bin/python3.11 /usr/bin/python

# Install Node.js (Required for AI Toolkit UI)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install PyTorch 2.4.0 specific version
RUN pip install --no-cache-dir torch==2.4.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

# Install Jupyter Lab
RUN pip install --no-cache-dir jupyterlab

# Clone and Setup AI Toolkit
WORKDIR /app
RUN git clone https://github.com/ostris/ai-toolkit.git
WORKDIR /app/ai-toolkit[ 1 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQEErIpbRQiYzern1YWfLNTuZpZjHeK0ueaMOQEoS43xnkIuG6qu_EkHe4mL2LJti8_WdQrHgSyz22lw1X3ft1AMFJNZS5tA_5130onreml0qWmA5VD74YiB0uoXBVQmGKLJSZagHZt_SJg=)][ 13 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH76tLZcbrX76QeCdt6kTi2s2RkAaKalJMCBGwuJgqKygCONz84iwEE9GhJOk_QQW4EiUzldBH_qWbnE0utplO8o7pb-ie4elR2xouFE7Nr3BPF18nV96GM1HsQVf19brkor6oA_P6ZSR_CksPoexHC5tBkpUnXoSAp6faEHGRnPH66EZk8Tk524T4=)]

# Install AI Toolkit Python Requirements[ 4 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQF0Znb_uV0ohRfDT6fdRBIwyYU336X8y4tinlFiOCiy4WQ_PfzhRUz4iIS3lLRSXatQBiDl_mG1pp0YxZkwy8JzNf2a-R3-28LPq1k8Ccp-tG7_179U0D1ar_PxA7X1eQ==)][ 13 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH76tLZcbrX76QeCdt6kTi2s2RkAaKalJMCBGwuJgqKygCONz84iwEE9GhJOk_QQW4EiUzldBH_qWbnE0utplO8o7pb-ie4elR2xouFE7Nr3BPF18nV96GM1HsQVf19brkor6oA_P6ZSR_CksPoexHC5tBkpUnXoSAp6faEHGRnPH66EZk8Tk524T4=)]
# We use --ignore-installed to prevent overwriting our specific PyTorch version
RUN pip install --no-cache-dir -r requirements.txt --ignore-installed torch torchvision torchaudio

# Setup AI Toolkit UI
WORKDIR /app/ai-toolkit/ui
RUN npm install
RUN npm run build[ 1 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQEErIpbRQiYzern1YWfLNTuZpZjHeK0ueaMOQEoS43xnkIuG6qu_EkHe4mL2LJti8_WdQrHgSyz22lw1X3ft1AMFJNZS5tA_5130onreml0qWmA5VD74YiB0uoXBVQmGKLJSZagHZt_SJg=)][ 13 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH76tLZcbrX76QeCdt6kTi2s2RkAaKalJMCBGwuJgqKygCONz84iwEE9GhJOk_QQW4EiUzldBH_qWbnE0utplO8o7pb-ie4elR2xouFE7Nr3BPF18nV96GM1HsQVf19brkor6oA_P6ZSR_CksPoexHC5tBkpUnXoSAp6faEHGRnPH66EZk8Tk524T4=)]

# Copy Start Script
COPY start.sh /start.sh
RUN chmod +x /start.sh[ 13 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH76tLZcbrX76QeCdt6kTi2s2RkAaKalJMCBGwuJgqKygCONz84iwEE9GhJOk_QQW4EiUzldBH_qWbnE0utplO8o7pb-ie4elR2xouFE7Nr3BPF18nV96GM1HsQVf19brkor6oA_P6ZSR_CksPoexHC5tBkpUnXoSAp6faEHGRnPH66EZk8Tk524T4=)][ 15 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHc5kCKJuA1sM36_VeoTFFvOa-1iqlHh0zeNk8IAZsaNgwcVuvqk5KKp9GH2Z4sa3IMuRMYBm50mCF8AmNPCy41TzY_y7_tAFyi-IyQxHX9E6380NRMkiy1Hilkr9-rZQmqqdzWf-Tlrpz6HMa4G68wLM_lfaT8YY757czvxFcMbU6_BMjjZsB5oD1U9Sbk8w==)]

# Expose Ports
EXPOSE 8888 8675

# Set Entrypoint
CMD ["/start.sh"]
```[ 6 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQFPhW3iH9a2IWXiTQpILoXJC3x26hxWdvaZot4px38-aBLEO57rKC6WrMd98Cd3iNli4TfwEp8_JqCneVD9vLuPsjsfgKK18uxzpCaJZGA91Lxf4OAfR1SImJyqMGBxwEzGBN1ZfXTHDz-1PPWHD3gsXf1MUWTwE3x-xHhQFcWIDg9MyfSGkLdEZlIvcjBQqQ_V)][ 13 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQH76tLZcbrX76QeCdt6kTi2s2RkAaKalJMCBGwuJgqKygCONz84iwEE9GhJOk_QQW4EiUzldBH_qWbnE0utplO8o7pb-ie4elR2xouFE7Nr3BPF18nV96GM1HsQVf19brkor6oA_P6ZSR_CksPoexHC5tBkpUnXoSAp6faEHGRnPH66EZk8Tk524T4=)][ 15 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHc5kCKJuA1sM36_VeoTFFvOa-1iqlHh0zeNk8IAZsaNgwcVuvqk5KKp9GH2Z4sa3IMuRMYBm50mCF8AmNPCy41TzY_y7_tAFyi-IyQxHX9E6380NRMkiy1Hilkr9-rZQmqqdzWf-Tlrpz6HMa4G68wLM_lfaT8YY757czvxFcMbU6_BMjjZsB5oD1U9Sbk8w==)][ 17 (https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQHzPHzkQfSh9GnKRG9IlhiTR-jHnD2AhLkxyE5L14ZODpzOCCxwKdbF6sL7Pn0veNuV2o74AtcWRiUtvFZEOmq2iguulxmrDUeCl-2-upzPGUhRgbAvJ-W98CapfBkk4j7f_d-qAibNcBZhgCmuv7M72po2xdP8ot2aczdd9_RyVPIG7aZmrq6OBXvomJNNaEfV)]

---
