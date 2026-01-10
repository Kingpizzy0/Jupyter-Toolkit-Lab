# Jupyter Toolkit Lab

A unified Docker container template for AI development on GPU cloud services like RunPod.io and Vast.ai. This container combines JupyterLab with the Ostris AI Toolkit for seamless machine learning workflows.

## Features

- **JupyterLab**: Full-featured data science notebook environment
- **Ostris AI Toolkit**: Advanced AI training and development tools with web UI
- **CUDA 12.8.1**: Latest CUDA support for optimal GPU performance
- **PyTorch 2.9.1**: Pre-installed with CUDA acceleration
- **Broad GPU Support**: Compatible with architectures from Ampere to Blackwell (compute capability 8.0-12.0)

## Supported GPUs

- NVIDIA A100, A10, A6000 (Ampere - 8.0, 8.6)
- NVIDIA H100 (Hopper - 9.0)
- NVIDIA RTX 4090, 4080 (Ada Lovelace - 8.9)
- NVIDIA B100, B200 (Blackwell - 10.0, 12.0)

## Quick Start

### Using on RunPod

1. Go to RunPod.io and create a new template
2. Use this Docker image: `yourusername/jupyter-toolkit-lab:latest`
3. Expose ports: `8888, 8675`
4. Set environment variables (optional):
   - `JUPYTER_PASSWORD`: Your JupyterLab password (default: "Password")
   - `JUPYTER_PORT`: JupyterLab port (default: 8888)
   - `AI_TOOLKIT_PORT`: AI Toolkit UI port (default: 8675)
5. Deploy your pod

### Using on Vast.ai

1. Search for an instance with your desired GPU
2. Use the Docker image: `yourusername/jupyter-toolkit-lab:latest`
3. Map ports `8888` and `8675`
4. Launch your instance

## Accessing Services

Once your container is running:

- **JupyterLab**: `http://your-instance-ip:8888`
  - Default password: `Password` (or your custom `JUPYTER_PASSWORD`)
  
- **AI Toolkit UI**: `http://your-instance-ip:8675`

## Building Locally

```bash
# Clone the repository
git clone https://github.com/yourusername/jupyter-toolkit-lab.git
cd jupyter-toolkit-lab

# Build the image
docker build -t jupyter-toolkit-lab:latest .

# Run locally
docker run -d \
  -p 8888:8888 \
  -p 8675:8675 \
  -e JUPYTER_PASSWORD="YourSecurePassword" \
  --gpus all \
  jupyter-toolkit-lab:latest
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `JUPYTER_PASSWORD` | `Password` | Password for JupyterLab access |
| `JUPYTER_PORT` | `8888` | Port for JupyterLab interface |
| `AI_TOOLKIT_PORT` | `8675` | Port for AI Toolkit UI |
| `GIT_COMMIT` | `main` | AI Toolkit git commit/branch to clone |

## Logs

Container logs are stored in `/var/log/`:
- JupyterLab: `/var/log/jupyter.log`

## Advanced Usage

### Custom AI Toolkit Version

Build with a specific commit:

```bash
docker build \
  --build-arg GIT_COMMIT=your-commit-hash \
  -t jupyter-toolkit-lab:custom .
```

### Persistent Storage

Mount volumes for persistent data:

```bash
docker run -d \
  -p 8888:8888 \
  -p 8675:8675 \
  -v /path/to/notebooks:/workspace \
  -v /path/to/models:/models \
  --gpus all \
  jupyter-toolkit-lab:latest
```

## Troubleshooting

### JupyterLab won't start
Check the logs: `docker logs <container-id>` or view `/var/log/jupyter.log`

### AI Toolkit UI not accessible
Ensure port 8675 is properly exposed and not blocked by firewall

### GPU not detected
Verify NVIDIA Docker runtime is installed: `docker run --rm --gpus all nvidia/cuda:12.8.1-base-ubuntu24.04 nvidia-smi`

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## License

This project builds upon the Ostris AI Toolkit. Please refer to the original project for licensing information.

## Acknowledgments

- [Ostris AI Toolkit](https://github.com/ostris/ai-toolkit)
- NVIDIA CUDA Toolkit
- JupyterLab Project
