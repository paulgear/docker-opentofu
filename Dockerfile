FROM golang:alpine

ENV TERRAFORM_VERSION=0.11.11

RUN apk add --update git bash openssh

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
git checkout v${TERRAFORM_VERSION} && \
/bin/bash scripts/build.sh

ENV AWSCLI_VERSION=1.16.96

RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates groff less bash make jq gettext-dev curl wget g++ zip git && \
    pip --no-cache-dir install --upgrade awscli==${AWSCLI_VERSION} && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*

ENV TERRAFORM_DOCS_VERSION 0.6.0
RUN curl -L -o /usr/local/bin/terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64 && \
    chmod +x /usr/local/bin/terraform-docs

ENV GIT_CHGLOG_VERSION 0.7.1
RUN curl -L -o /usr/local/bin/git-chglog https://github.com/git-chglog/git-chglog/releases/download/${GIT_CHGLOG_VERSION}/git-chglog_linux_amd64 && \
    chmod +x /usr/local/bin/git-chglog

RUN mkdir -p /work

WORKDIR /work
ENTRYPOINT ["terraform"]

CMD ["--help"]
