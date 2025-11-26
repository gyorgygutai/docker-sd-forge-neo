IMAGE_NAME = ghcr.io/gyorgygutai/saladcloud-sd-forge-neo
TAG = latest
PLATFORM = linux/amd64
CACHEBUST = $(shell date +%s)

build:
	docker buildx build --platform $(PLATFORM) --build-arg CACHEBUST=$(CACHEBUST) -t $(IMAGE_NAME):$(TAG) .

push:
	docker buildx build --platform $(PLATFORM) --build-arg CACHEBUST=$(CACHEBUST) -t $(IMAGE_NAME):$(TAG) --push .

build-local:
	docker build --build-arg CACHEBUST=$(CACHEBUST) -t $(IMAGE_NAME):local .

test:
	docker run --rm -p 7870:7870 $(IMAGE_NAME):local

build-multi:
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg CACHEBUST=$(CACHEBUST) -t $(IMAGE_NAME):$(TAG) --push .

clean:
	docker system prune -af

rebuild: clean push

.PHONY: build push release build-local test build-multi clean rebuild