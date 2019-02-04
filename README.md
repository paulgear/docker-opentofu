# docker-terraform-utils

Docker image with `terraform` and other useful utilities

## Why?

This image is used when following the [3 Musketeers] pattern. By running `terraform` inside Docker, we ensure consistency, control and confidence.

  * Consistency: when developing automated processes that use `terraform`, you can be sure that they will function the same whether you run it on your Windows workstation or on a Jenkins build agent.
  * Control: by specifying the version of the image in [docker-compose.yml][], we can deploy to two incompatible versions of Terraform simultaneously.
  * Confidence: reliable deployments build confidence in the use of CI/CD pipelines, creating a positive feedback loop that encourages developers to use CI/CD

[3 Musketeers]: https://3musketeers.io/


## How To Use

Makefile:
```Makefile
deploy:
	docker-compose run --rm terraform apply
```

docker-compose.yml:
```yaml
services:
  terraform:
    image: cmdlabs/terraform-utils:1.0.0
    volumes:
      - .:/work:Z
```
