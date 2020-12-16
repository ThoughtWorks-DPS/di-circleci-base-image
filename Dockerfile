FROM twdps/di-circleci-remote-docker:2020.12.1

LABEL maintainer=<nchenewe@thoughtworks.com>

# NOTE: conftest v0.22.0 is a breaking change. The release notes do not suggest that it  
# should be breaking but it no longer reads --data files and --trace does not work
ENV CONFTEST_VERSION=0.21.0

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004,SC2035
RUN sudo sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories" && \
    sudo apk add --no-cache \
             bash==5.0.17-r0 \
             curl==7.69.1-r3 \
             openssl==1.1.1g-r0 \
             gnupg==2.2.23-r0 \
             docker==19.03.12-r0 \
             openrc==0.42.1-r11 \
             libstdc++==9.3.0-r2 \
             nodejs==12.18.4-r0 \
             npm==12.18.4-r0 \
             jq==1.6_rc1-r1 && \
    sudo apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted \
             secrethub-cli==0.41.2-r0 && \
    sudo npm install -g \
             snyk@1.434.2 \
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
