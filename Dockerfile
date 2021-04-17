FROM twdps/di-circleci-remote-docker:2021.04.1

LABEL maintainer=<nchenewe@thoughtworks.com>

ENV CONFTEST_VERSION=0.24.0
ENV CHAMBER_VERSION=2.9.1

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004,SC2035
RUN sudo sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories" && \
    sudo apk add --no-cache \
             bash==5.1.0-r0 \
             curl==7.76.1-r0 \
             openssl==1.1.1k-r0 \
             gnupg==2.2.27-r0 \
             docker==20.10.3-r1 \
             openrc==0.42.1-r19 \
             nodejs==14.16.1-r1 \
             npm==14.16.1-r1 \
             jq==1.6_rc1-r1 && \
    sudo apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted \
             secrethub-cli==0.41.2-r0 && \
    sudo npm install -g \
             snyk@1.530.0 \
             bats@1.3.0 && \
    sudo wget https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo mv conftest /usr/local/bin && sudo rm * && \
    sudo curl -LOs https://github.com/segmentio/chamber/releases/download/v${CHAMBER_VERSION}/chamber-v${CHAMBER_VERSION}-linux-amd64 && \
    sudo chmod +x chamber-v${CHAMBER_VERSION}-linux-amd64 && \
    sudo mv chamber-v${CHAMBER_VERSION}-linux-amd64 /usr/local/bin/chamber && \
    sudo rc-update add docker boot && \
    mkdir /home/circleci/.gnupg && \
    echo 'allow-loopback-pinentry' > /home/circleci/.gnupg/gpg-agent.conf && \
    echo 'pinentry-mode loopback' > /home/circleci/.gnupg/gpg.conf && \
    chmod 700 /home/circleci/.gnupg && chmod 600 /home/circleci/.gnupg/*

USER circleci

HEALTHCHECK NONE
