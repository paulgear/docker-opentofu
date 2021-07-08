FROM alpine:3.11

RUN apk add --update --no-cache bash ca-certificates curl git openssh-client python3 tree zip

ENV TERRAFORM_VERSION=1.0.0
RUN curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /tmp/ && \
    mv /tmp/terraform /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform && \
    rm -rf /tmp/terraform.zip

ENV AWSCLI_VERSION=1.19.52
RUN pip3 --no-cache-dir install --upgrade awscli==${AWSCLI_VERSION}

ENV TERRAFORM_DOCS_VERSION=0.12.1
RUN curl -L -o /usr/local/bin/terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64 && \
    chmod +x /usr/local/bin/terraform-docs

# Is there a reason why this needs to be separate from the layer above?
# If so, it would be great to have it documented here.
RUN pip3 --no-cache-dir install --upgrade argparse python-gitlab requests

RUN mkdir -p /work

WORKDIR /work

ENTRYPOINT ["terraform"]
