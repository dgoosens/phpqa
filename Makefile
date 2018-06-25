default: build

build: build-latest build-alpine
.PHONY: build

build-latest: BUILD_TAG ?= jakzal/phpqa:latest
build-latest:
	docker build -t $(BUILD_TAG) .
.PHONY: build-latest

build-alpine: BUILD_TAG ?= jakzal/phpqa:alpine
build-alpine:
	docker build -f Dockerfile-alpine -t $(BUILD_TAG) .
.PHONY: build-alpine

build-nightly-latest: BUILD_TAG ?= jakzal/phpqa-nightly:$(shell date +%y%m%d)
build-nightly-latest:
	docker build -t $(BUILD_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(BUILD_TAG)
.PHONY: build-nightly-latest

build-nightly-alpine: BUILD_TAG ?= jakzal/phpqa-nightly:$(shell date +%y%m%d)-alpine
build-nightly-alpine:
	docker build -f Dockerfile-alpine -t $(BUILD_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(BUILD_TAG)
.PHONY: build-nightly-alpine
