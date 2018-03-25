CONFIG_FILE := Makefile.conf
BINARY_NAME := binary.tar.gz
BINARY_EXIST = false
EXTRACT_BINARY_NAME := content
EXTRACT_BINARY_EXIST = false
# Check config file exist
ifeq ($(wildcard $(CONFIG_FILE)),)
$(error $(CONFIG_FILE) not found. See README.md for an issue.)
endif
include $(CONFIG_FILE)
# It's loaded, we can work
ifeq ($(wildcard $(BINARY_NAME)),$(BINARY_NAME))
BINARY_EXIST = true
endif
ifeq ($(wildcard $(EXTRACT_BINARY_NAME)),$(EXTRACT_BINARY_NAME))
EXTRACT_BINARY_EXIST = false
endif
default: hugo-new

docker-build:
	$(info Check if dependancies exist.)
ifeq ($(wildcard $(EXTRACT_BINARY_NAME)),$(EXTRACT_BINARY_NAME))
		$(info Directory exist ! We can continue.)
else
ifeq ($(wildcard $(BINARY_NAME)),)
			$(info Not exist. Download library for install Hugo v$(HUGO_VERSION) in the docker image.)
			curl -L https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_linux-arm.tar.gz > ./$(BINARY_NAME)
else
			$(info File exist ! We can continue.)
endif
		mkdir $(EXTRACT_BINARY_NAME)/
		tar xzf $(BINARY_NAME) -C $(EXTRACT_BINARY_NAME)/
		rm $(BINARY_NAME)
		cd $(EXTRACT_BINARY_NAME)
		ls -la $(EXTRACT_BINARY_NAME)/
endif
	$(info Start process for the image build)
	docker rmi -f $(NAMESPACE)/$(IMAGE_NAME):bak || true
	docker tag $(NAMESPACE)/$(IMAGE_NAME) $(NAMESPACE)/$(IMAGE_NAME):bak || true
	docker rmi -f $(NAMESPACE)/$(IMAGE_NAME) || true
	docker build -t $(NAMESPACE)/$(IMAGE_NAME) --build-arg HUGO=$(HUGO_VERSION) .
	rm -rf content

docker-logs:
	docker logs $(CONTAINER_NAME)

docker-prompt:
	docker exec -it $(CONTAINER_NAME) /bin/ash/

docker-run:
		docker run --name $(CONTAINER_NAME) -d -p $(PORT):$(PORT) -v $(HUGO_PATH)/$(HUGO_DIR):/www $(NAMESPACE)/$(IMAGE_NAME) server -b http://$(IP)/ --bind=0.0.0.0 -p $(PORT) -w -D

hugo-new:
	$(info Setting up Hugo project in $(HUGO_PATH)/$(HUGO_DIR).)
	mkdir -p $(HUGO_PATH)/$(HUGO_DIR)
	docker run --rm -v $(HUGO_PATH)/$(HUGO_DIR):/www $(NAMESPACE)/$(IMAGE_NAME) new site .
	$(info Now you can set a specific theme or get them all with `hugo-themes`.)

hugo-themes:
	$(info Download all hugo themes for this project.)
	git clone --recursive --depth 1 https://github.com/gohugoio/hugoThemes $(HUGO_PATH)/$(HUGO_DIR)/themes

hugo-live: docker-run docker-logs

hugo-live-out:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME)

hugo-live-restart: hugo-live-out hugo-live

hugo-build:
	$(info Build your website project into `public`)
	docker run --rm -v $(HUGO_PATH)/$(HUGO_DIR):/www $(NAMESPACE)/$(IMAGE_NAME)

hugo-post:
	$(info Try to create a new post in $(HUGO_PATH)/$(HUGO_DIR)/content/post/`)
	docker run --rm -v $(HUGO_PATH)/$(HUGO_DIR):/www $(NAMESPACE)/$(IMAGE_NAME) new post/new.md
