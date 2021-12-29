FROM alpine:3

ENV BINDIR=/usr/local/bin
RUN mkdir -p ~/.tflint.d/plugins

# integrated Azure instructions from https://github.com/Azure/azure-cli/issues/19591#issue-998886589
RUN apk add --update --upgrade --no-cache \
    apk-tools \
    bash \
    ca-certificates \
    cargo \
    curl \
    gcc \
    git \
    libffi-dev \
    make \
    musl-dev \
    openssh-client \
    openssl-dev \
    python3 \
    python3-dev \
    py3-pip \
    tree \
    zip
RUN pip --no-cache-dir install --upgrade \
    argparse \
    awscli \
    azure-cli \
    boto3 \
    pan-os-python \
    pip \
    python-gitlab \
    requests

WORKDIR /tmp/installer

ARG TERRAFORM_DOCS_VERSION=0.16.0
RUN curl -L -o terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz && \
    tar -xvf terraform-docs.tar.gz && \
    mv terraform-docs ${BINDIR}/ && \
    rm -rf *

ARG TERRAFORM_VERSION=1.0.11
RUN curl -L -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform.zip && \
    mv terraform ${BINDIR} && \
    chmod +x ${BINDIR}/terraform && \
    rm -rf *

ARG TFLINT_VERSION=0.34.1
RUN wget -O tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_linux_amd64.zip && \
    unzip tflint.zip -d ${BINDIR}/ && \
    rm -rf *

ARG TFLINT_RULESET_AWS_VERSION=0.10.1
RUN wget -O tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${TFLINT_RULESET_AWS_VERSION}"/tflint-ruleset-aws_linux_amd64.zip && \
    unzip tflint-ruleset-aws.zip -d ~/.tflint.d/plugins && \
   rm tflint-ruleset-aws.zip

WORKDIR /work
RUN rmdir /tmp/installer

ENTRYPOINT ["bash"]
