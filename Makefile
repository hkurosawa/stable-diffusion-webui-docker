IMAGE_NAME = stable-diffusion-webui

IMAGE: stable-diffusion-webui
	docker build --no-cache -t $(IMAGE_NAME):latest .

stable-diffusion-webui:
	git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui

stable-diffusion-webui/venv: stable-diffusion-webui
	docker run -it --rm --gpus all --mount type=bind,src="$(shell pwd)/stable-diffusion-webui",dst=/home/nonroot/stable-diffusion-webui $(IMAGE_NAME)  python -m venv venv

RUN-CONSOLE: stable-diffusion-webui
	docker run -it --rm --gpus all --mount type=bind,src="$(shell pwd)/stable-diffusion-webui",dst=/home/nonroot/stable-diffusion-webui $(IMAGE_NAME) 

RUN-WEBUI: stable-diffusion-webui/venv
	# https://github.com/AUTOMATIC1111/stable-diffusion-webui/discussions/5303#discussioncomment-6423824
	docker run -it --rm --gpus all -p 7860:7860/tcp --mount type=bind,src="$(shell pwd)/stable-diffusion-webui",dst=/home/nonroot/stable-diffusion-webui $(IMAGE_NAME) ./webui.sh --xformers --listen