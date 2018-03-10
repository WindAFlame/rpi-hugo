NAMESPACE := ew
IMAGENAME := $(shell basename `git rev-parse --show-toplevel`)
SHA := $(shell git rev-parse --short HEAD)
targz_file := $(shell cat FILEPATH)
timestamp := $(shell date +"%Y%m%d%H%M")
VERSION :=$(shell cat VERSION)
#| sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]$//')        	

default: download dockerbuild cleanenv push

download:
	curl -L https://github.com/gohugoio/hugo/releases/download/v$(VERSION)/hugo_$(VERSION)_linux-arm.tar.gz > ./binary.tar.gz
	mkdir content/
	tar xzf binary.tar.gz -C content/
	cd content
	ls -la content/

dockerbuild:
	docker rmi -f $(NAMESPACE)/$(IMAGENAME):bak || true
	docker tag $(NAMESPACE)/$(IMAGENAME) $(NAMESPACE)/$(IMAGENAME):bak || true
	docker rmi -f $(NAMESPACE)/$(IMAGENAME) || true
	docker build -t $(NAMESPACE)/$(IMAGENAME) --build-arg HUGO=$(HUGO_VERSION) --build-arg PORT=1313 .

cleanenv:
	rm binary.tar.gz
	rm -rf content

testimg:
	docker rm -f new-$(IMAGENAME) || true
	docker run -d --name new-$(IMAGENAME) $(NAMESPACE)/$(IMAGENAME):latest
	docker inspect -f '{{.NetworkSettings.IPAddress}}' new-$(IMAGENAME)
	docker logs -f new-$(IMAGENAME)

push:
	# push VERSION
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)
	docker rmi $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION) || true
	# push commit SHA
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(SHA)
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(SHA)
	docker rmi $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(SHA) || true
	# push timestamp
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(timestamp)
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(timestamp)
	docker rmi $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(timestamp) || true
	# push latest
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):latest
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):latest
	docker rmi $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):latest || true
                        	
