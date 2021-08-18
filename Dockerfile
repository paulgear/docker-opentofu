FROM alpine:3.11

RUN mkdir -p /work

RUN apk add --update --upgrade --no-cache bash ca-certificates curl git openssh-client python3 tree zip apk-tools

ENV AWSCLI_VERSION=1.20.23
RUN pip3 --no-cache-dir install --upgrade awscli==${AWSCLI_VERSION} argparse python-gitlab requests

ENV TERRAFORM_DOCS_VERSION=0.15.0
RUN curl -L -o /tmp/terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz && \
    tar -xvf /tmp/terraform-docs.tar.gz -C /tmp && \
    mv /tmp/terraform-docs /usr/local/bin/ && \
    rm -rf /tmp/*

ENV TERRAFORM_VERSION=1.0.4
RUN curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /tmp/ && \
    mv /tmp/terraform /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform && \
    rm -rf /tmp/*

WORKDIR /work

ENTRYPOINT ["terraform"]
