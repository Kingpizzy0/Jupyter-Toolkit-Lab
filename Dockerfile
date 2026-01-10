# Jupyter Toolkit Lab - Unified Docker Image
FROM nvidia/cuda:12.8.1-devel-ubuntu24.04

LABEL maintainer="jupyter-toolkit-lab"
LABEL description="Jupyter Toolkit Lab - AI Development Environment for GPU Cloud Services"
LABEL version="1.0"

# Set noninteractive to avoid timezone prompts
ENV DEBIAN_FRONTEND=noninteractive

# CUDA architecture list for broad GPU compatibility (including Blackwell)
ENV TORCH_CUDA_ARCH_LIST="8.0 8.6 8.9 9.0 10.0 12.0"

# Default ports (can be overridden)
ENV JUPYTER_PORT=8888
ENV AI_TOOLKIT_PORT=8675
ENV COMFYUI_PORT=8188

# Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    curl \
    build-essential \
    cmake \
    wget \
    python3.12 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-wheel \
    python3-venv \
    ffmpeg \
    tmux \
    htop \
    python3-opencv \
    openssh-client \
    openssh-server \
    openssl \
    rsync \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install nodejs
WORKDIR /tmp
RUN curl -sL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get update && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Set aliases for python and pip
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install PyTorch 2.9.1 with CUDA 12.8 support before cache bust
RUN pip install --no-cache-dir torch==2.9.1 torchvision==0.24.1 torchaudio==2.9.1 \
    --index-url https://download.pytorch.org/whl/cu128 --break-system-packages

# Install JupyterLab
RUN pip install --no-cache-dir jupyterlab --break-system-packages

# Cache busting for git clone
ARG CACHEBUST=1234
ARG GIT_COMMIT=main
RUN echo "Cache bust: ${CACHEBUST}" && \
    git clone https://github.com/ostris/ai-toolkit.git && \
    cd ai-toolkit && \
    git checkout ${GIT_COMMIT}

WORKDIR /app/ai-toolkit

# Install Python dependencies
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt && \
    pip install setuptools==69.5.1 --no-cache-dir --break-system-packages

# Clone and setup ComfyUI
WORKDIR /app
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip install --no-cache-dir --break-system-packages -r requirements.txt

# Download Z-Image Turbo models for ComfyUI
WORKDIR /app/ComfyUI
RUN mkdir -p models/diffusion_models models/text_encoders models/vae

# Download Z-Image Turbo diffusion model
RUN wget -c https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors \
    -O models/diffusion_models/z_image_turbo_bf16.safetensors

# Download Z-Image Turbo text encoder
RUN wget -c https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors \
    -O models/text_encoders/qwen_3_4b.safetensors

# Download Z-Image Turbo VAE
RUN wget -c https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors \
    -O models/vae/ae.safetensors

# Build UI
WORKDIR /app/ai-toolkit/ui
RUN npm install && \
    npm run build && \
    npm run update_db

# Expose ports for Jupyter Lab, AI Toolkit, and ComfyUI
EXPOSE 8888 8675 8188

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:${AI_TOOLKIT_PORT}/ || exit 1

WORKDIR /

COPY start.sh /start.sh
RUN chmod +x /start.sh && sed -i 's/\r$//' /start.sh

CMD ["/start.sh"]
