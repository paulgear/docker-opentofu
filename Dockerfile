FROM    paulgear/base:latest

ARG     APT_PKGS="\
git \
gnupg \
groff \
make \
python3-colorama \
python3-dateutil \
python3-jmespath \
python3-pip \
python3-pyasn1 \
python3-rsa \
python3-yaml \
software-properties-common \
unzip \
"
ARG     http_proxy
ARG     https_proxy

ENV     DEBIAN_FRONTEND=noninteractive
ENV     http_proxy=${http_proxy}
ENV     https_proxy=${https_proxy}
ENV     HTTP_PROXY=${http_proxy}
ENV     HTTPS_PROXY=${https_proxy}

RUN     apt-get update && \
        apt-get install --no-install-recommends -y ${APT_PKGS} && \
        rm -rf /var/lib/apt/lists/*

RUN     curl -fsSL https://get.opentofu.org/opentofu.gpg -o /etc/apt/keyrings/opentofu.gpg && \
        curl -fsSL https://packages.opentofu.org/opentofu/tofu/gpgkey | gpg --no-tty --batch --dearmor -o /etc/apt/keyrings/opentofu-repo.gpg && \
        chmod a+r /etc/apt/keyrings/opentofu.gpg /etc/apt/keyrings/opentofu-repo.gpg && \
        echo "deb [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main" >/etc/apt/sources.list.d/opentofu.list && \
        apt-get update && \
        apt-get install --no-install-recommends -y tofu && \
        rm -rf /var/lib/apt/lists/*

ARG     PIP_PKGS="\
awscli \
boto3 \
"

RUN     pip --no-cache-dir install --upgrade --break-system-packages ${PIP_PKGS}

WORKDIR /tmp/installer
ARG     BINDIR=/usr/local/bin
RUN     mkdir -p ~/.tflint.d/plugins

ARG     TERRAFORM_DOCS_VERSION=0.18.0
RUN     curl -sL -o terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz && \
        tar -xvf terraform-docs.tar.gz && \
        mv terraform-docs ${BINDIR}/ && \
        rm -rf *

ARG     TFLINT_VERSION=0.51.1
RUN     curl -sL -o tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_linux_amd64.zip && \
        unzip tflint.zip -d ${BINDIR}/ && \
        rm -rf *

ARG     TFLINT_RULESET_AWS_VERSION=0.32.0
RUN     curl -sL -o tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${TFLINT_RULESET_AWS_VERSION}"/tflint-ruleset-aws_linux_amd64.zip && \
        unzip tflint-ruleset-aws.zip -d ~/.tflint.d/plugins && \
        rm tflint-ruleset-aws.zip

RUN     tofu --version && \
        terraform-docs --version && \
        tflint --version

USER    ubuntu
WORKDIR /work
