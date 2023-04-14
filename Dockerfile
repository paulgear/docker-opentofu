FROM    paulgear/base:latest

ARG     APT_PKGS="\
apt-transport-https \
curl \
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
ENV     DEBIAN_FRONTEND=noninteractive

RUN     apt update && \
        apt install --no-install-recommends -y ${APT_PKGS} && \
        curl -s https://packages.microsoft.com/keys/microsoft.asc -o /etc/apt/trusted.gpg.d/microsoft.asc && \
        add-apt-repository https://packages.microsoft.com/repos/azure-cli && \
        apt install --no-install-recommends -y azure-cli && \
        rm -rf /var/lib/apt/lists/*

ARG     PIP_PKGS="\
awscli \
boto3 \
"

RUN     pip --no-cache-dir install --upgrade ${PIP_PKGS}

WORKDIR /tmp/installer
ARG     BINDIR=/usr/local/bin
RUN     mkdir -p ~/.tflint.d/plugins

ARG     TERRAFORM_DOCS_VERSION=0.16.0
RUN     curl -sL -o terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz && \
        tar -xvf terraform-docs.tar.gz && \
        mv terraform-docs ${BINDIR}/ && \
        rm -rf *

ARG     TERRAFORM_VERSION=1.4.5
RUN     curl -sL -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
        unzip terraform.zip && \
        mv terraform ${BINDIR} && \
        chmod +x ${BINDIR}/terraform && \
        rm -rf *

ARG     TFLINT_VERSION=0.46.0
RUN     curl -sL -o tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_linux_amd64.zip && \
        unzip tflint.zip -d ${BINDIR}/ && \
        rm -rf *

ARG     TFLINT_RULESET_AWS_VERSION=0.22.1
RUN     curl -sL -o tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${TFLINT_RULESET_AWS_VERSION}"/tflint-ruleset-aws_linux_amd64.zip && \
        unzip tflint-ruleset-aws.zip -d ~/.tflint.d/plugins && \
        rm tflint-ruleset-aws.zip

RUN     terraform --version && \
        terraform-docs --version && \
        tflint --version

WORKDIR /work

ENTRYPOINT ["bash"]
