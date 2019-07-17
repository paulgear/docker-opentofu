VERSION = 4.4.0
IMAGE_NAME ?= cmdlabs/terraform-utils:$(VERSION)

build:
	docker build -t $(IMAGE_NAME) .
PHONY: build

pull:
	docker pull $(IMAGE_NAME)
PHONY: pull

shell:
	docker run --rm -it -v $(PWD):/work:Z -w /work --entrypoint '' $(IMAGE_NAME) /bin/sh
PHONY: shell

test:
	docker-compose -f docker-compose.test.yml up --build --quiet-pull --exit-code-from sut
	docker-compose -f docker-compose.test.yml down --rmi all
PHONY: test

clean:
	docker-compose -f docker-compose.test.yml down --rmi all
PHONY: clean

tag:
	git tag $(VERSION)
	git push origin $(VERSION)
PHONY: tag
