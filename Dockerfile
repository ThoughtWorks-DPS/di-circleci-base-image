FROM twdps/di-circleci-remote-docker:2021.01.1

LABEL maintainer=<nchenewe@thoughtworks.com>

# NOTE: conftest v0.22.0 is a breaking change. The release notes do not suggest that it  
# should be breaking but it no longer reads --data files and --trace does not work
ENV CONFTEST_VERSION=0.21.0

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004,SC2035
RUN sudo sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories" && \
    sudo apk add --no-cache \
             bash==5.1.0-r0 \
             curl==7.74.0-r0 \
             openssl==1.1.1i-r0 \
             gnupg==2.2.27-r0 \
             docker==20.10.2-r0 \
             openrc==0.42.1-r19 \
             libstdc++==10.2.1_pre1-r3 \
             nodejs==14.15.4-r0 \
             npm==14.15.4-r0 \
             jq==1.6_rc1-r1 && \
    sudo apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted \
             secrethub-cli==0.41.2-r0 && \
    sudo npm install -g \
             snyk@1.440.1 \
             bats@1.2.1 && \
    sudo wget https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo mv conftest /usr/local/bin && sudo rm * && \
    sudo rc-update add docker boot && \
    mkdir /home/circleci/.gnupg && \
    echo 'allow-loopback-pinentry' > /home/circleci/.gnupg/gpg-agent.conf && \
    echo 'pinentry-mode loopback' > /home/circleci/.gnupg/gpg.conf && \
    chmod 700 /home/circleci/.gnupg && chmod 600 /home/circleci/.gnupg/*

USER circleci

HEALTHCHECK NONE
