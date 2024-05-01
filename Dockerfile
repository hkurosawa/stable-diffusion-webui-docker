FROM gpu-enabled-jupyterlab-cuda11.8.0-devel-ubuntu22.04 
RUN apt-get update
RUN apt-get install bc libtcmalloc-minimal4 libglu1-mesa-dev libglib2.0-0 python3-venv git -y

RUN useradd -m nonroot
USER nonroot
RUN mkdir /home/nonroot/stable-diffusion-webui
WORKDIR /home/nonroot/stable-diffusion-webui
