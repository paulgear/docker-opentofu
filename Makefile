VERSION = 1.0.0
IMAGE_NAME ?= cmdlabs/terraform-utils:$(VERSION)

dockerBuild:
	docker build -t $(IMAGE_NAME) .

pull:
	docker pull $(IMAGE_NAME)

shell:
	docker run --rm -it -v $(PWD):/work:Z -w /work --entrypoint '' $(IMAGE_NAME) /bin/sh

tag:
	# -git tag -d $(VERSION)
	# -git push origin :refs/tags/$(VERSION)
	git tag $(VERSION)
	git push origin $(VERSION)

