FROM twdps/di-circleci-remote-docker:2020.06

LABEL maintainer=<nchenewe@thoughtworks.com>

ENV CONFTEST_VERSION=0.19.0

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004,SC2035
RUN sudo sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories" && \
    sudo apk add --no-cache \
             bash==5.0.18-r0 \
             curl==7.71.1-r0 \
             openssl==1.1.1g-r0 \
             gnupg==2.2.21-r0 \
             docker==19.03.11-r0 \
             openrc==0.42.1-r10 \
             libstdc++==9.3.0-r3 \
             nodejs==12.18.2-r0 \
             npm==12.18.2-r0 \
             jq==1.6_rc1-r1 && \
    sudo apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted \
             secrethub-cli==0.40.0-r0 && \
    sudo npm install -g \
             snyk@1.361.3 \
             bats@1.1.0 && \
    sudo wget https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    sudo mv conftest /usr/local/bin && sudo rm * && \
    sudo rc-update add docker boot && \
    sudo mkdir /home/circleci/project/.gnupg && \
    sudo sh -c "echo 'allow-loopback-pinentry' > /home/circleci/project/.gnupg/gpg-agent.conf" && \
    sudo sh -c "echo 'pinentry-mode loopback' > /home/circleci/project/.gnupg/gpg.conf"&& \
    sudo chmod -R 600 /home/circleci/project/.gnupg

USER circleci

HEALTHCHECK NONE
