FROM gpu-enabled-jupyterlab-cuda11.8.0-devel-ubuntu22.04 
RUN apt-get update
RUN apt-get install bc libtcmalloc-minimal4 libglu1-mesa-dev libglib2.0-0 python3-dev python3-venv git xdg-utils -y

RUN useradd -m nonroot
USER nonroot
RUN mkdir /home/nonroot/stable-diffusion-webui
WORKDIR /home/nonroot/stable-diffusion-webui

#https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/1305
#ENV VIRTUAL_ENV /home/nonroot/stable-diffusion-webui/venv
#ENV PATH /home/nonroot/stable-diffusion-webui/venv:$PATH
#RUN pip install --no-binary opencv-python opencv-python --force-reinstall
 