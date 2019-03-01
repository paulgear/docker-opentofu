VERSION = 1.0.0
IMAGE_NAME ?= cmdlabs/terraform-utils:$(VERSION)

dockerBuild:
	docker build -t $(IMAGE_NAME) .

pull:
	docker pull $(IMAGE_NAME)

shell:
	docker run --rm -it -v $(PWD):/work:Z -w /work --entrypoint '' $(IMAGE_NAME) /bin/sh

test:
	docker-compose -f docker-compose.test.yml up --build --quiet-pull --exit-code-from sut
	docker-compose -f docker-compose.test.yml down --rmi all

PHONY: clean
clean:
	docker-compose -f docker-compose.test.yml down --rmi all 

tag:
	# -git tag -d $(VERSION)
	# -git push origin :refs/tags/$(VERSION)
	git tag $(VERSION)
	git push origin $(VERSION)

