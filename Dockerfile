FROM gpu-enabled-ubuntu-20.04-jupyterlab-base

#RUN mkdir stable-diffusion-webui
#RUN cd stable-diffusion-webui

WORKDIR src

RUN apt-get update
RUN apt-get install -y  wget git python3 python3-venv

# https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Install-and-Run-on-NVidia-GPUs
# Manual Installation
RUN pip install torch --extra-index-url https://download.pytorch.org/whl/cu113

# clone web ui and go into its directory
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
WORKDIR stable-diffusion-webui

# clone repositories for Stable Diffusion and (optionally) CodeFormer
RUN mkdir repositories
RUN git clone https://github.com/CompVis/stable-diffusion.git repositories/stable-diffusion
RUN git clone https://github.com/CompVis/taming-transformers.git repositories/taming-transformers
RUN git clone https://github.com/sczhou/CodeFormer.git repositories/CodeFormer
RUN git clone https://github.com/salesforce/BLIP.git repositories/BLIP

# switch module versions to meet requirements
RUN pip install protobuf==3.20.3 scipy==1.9.1 numpy==1.23.5

# install requirements of Stable Diffusion
RUN pip install transformers==4.19.2 diffusers invisible-watermark --prefer-binary

# install k-diffusion
RUN pip install git+https://github.com/crowsonkb/k-diffusion.git --prefer-binary

# (optional) install GFPGAN (face restoration)
RUN pip install git+https://github.com/TencentARC/GFPGAN.git --prefer-binary

# (optional) install requirements for CodeFormer (face restoration)
RUN pip install -r repositories/CodeFormer/requirements.txt --prefer-binary


#-----
# install requirements of web ui
RUN pip install -r requirements.txt  --prefer-binary


# 以降、python webui.shで起動しないので改変した部分
RUN git clone https://github.com/Stability-AI/stablediffusion.git repositories/stable-diffusion-stability-ai
RUN git clone https://github.com/crowsonkb/k-diffusion.git repositories/k-diffusion

RUN pip uninstall -y jupyterlab-server
RUN pip install requests==2.25.1 open_clip_torch
RUN pip install -r requirements_versions.txt

RUN apt-get install -y libgl1

# https://qiita.com/yagince/items/deba267f789604643bab
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y libglib2.0-0