IMAGE_NAME = stable-diffusion-webui

IMAGE:
	docker build -t $(IMAGE_NAME):latest .

RUN-CONSOLE:
	docker run -it --rm --gpus all -p 7860:7860 --ip='*' --mount type=bind,src="$(shell pwd)/models",dst=/src/stable-diffusion-webui/models $(IMAGE_NAME) python webui.py --listen
