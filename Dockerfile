FROM alpine:3.11

RUN mkdir -p /work ~/.tflint.d/plugins

RUN apk add --update --upgrade --no-cache bash ca-certificates curl git openssh-client python3 tree zip apk-tools

ARG AWSCLI_VERSION=1.20.23
RUN pip3 --no-cache-dir install --upgrade awscli==${AWSCLI_VERSION} argparse python-gitlab requests pan-os-python boto3

ARG TERRAFORM_DOCS_VERSION=0.16.0
RUN curl -L -o /tmp/terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz && \
    tar -xvf /tmp/terraform-docs.tar.gz -C /tmp && \
    mv /tmp/terraform-docs /usr/local/bin/ && \
    rm -rf /tmp/*

ARG TERRAFORM_VERSION=1.0.9
RUN curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /tmp/ && \
    mv /tmp/terraform /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform && \
    rm -rf /tmp/*

ARG TFLINT_VERSION=0.33.0
ARG TFLINT_RULESET_AWS_VERSION=0.8.0
RUN wget -O /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_linux_amd64.zip && \
    unzip /tmp/tflint.zip -d /usr/local/bin  && \
    rm -rf /tmp/*

RUN wget -O /tmp/tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${TFLINT_RULESET_AWS_VERSION}"/tflint-ruleset-aws_linux_amd64.zip \
  && unzip /tmp/tflint-ruleset-aws.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-aws.zip

WORKDIR /work

ENTRYPOINT ["terraform"]
