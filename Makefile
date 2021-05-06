PLATFORMS = linux/amd64,linux/i386,linux/arm64,linux/arm/v7,linux/arm/v6,linux/ppc64le,linux/s390x
VERSION = $(shell cat VERSION)
BINFMT = a7996909642ee92942dcd6cff44b9b95f08dad64
#DOCKER_USER = test
#DOCKER_PASS = test
ifeq ($(REPO),)
  REPO = prometheus
endif
ifeq ($(CIRCLE_TAG),)
	TAG = latest
else
	TAG = $(CIRCLE_TAG)
endif

.PHONY: all init build clean

all: init build clean

init: clean
	@docker run --rm --privileged docker/binfmt:$(BINFMT)
	@docker buildx create --name pdf2pptx_builder
	@docker buildx use pdf2pptx_builder
	@docker buildx inspect --bootstrap

build:
	@docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)
	@docker buildx build \
			--build-arg BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
			--build-arg VCS_REF=$(shell git rev-parse --short HEAD) \
			--build-arg VCS_URL=$(shell git config --get remote.origin.url) \
			--build-arg VERSION=$(VERSION) \
			--platform $(PLATFORMS) \
			--push \
			-t $(REPO):$(TAG) .
	@docker logout

clean:
	@docker buildx rm pdf2pptx_builder | true
