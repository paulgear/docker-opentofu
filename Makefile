TERRAFORM_VERSION = 0.11.11
IMAGE_NAME ?= cmdlabs/terraform-utils:$(TERRAFORM_VERSION)

dockerBuild:
	docker build -t $(IMAGE_NAME) .

pull:
	docker pull $(IMAGE_NAME)

shell:
	docker run --rm -it -v $(PWD):/opt/app:Z -w /opt/app $(IMAGE_NAME) sh

tag:
	-git tag -d $(TERRAFORM_VERSION)
	-git push origin :refs/tags/$(TERRAFORM_VERSION)
	git tag $(TERRAFORM_VERSION)
	git push origin $(TERRAFORM_VERSION)

