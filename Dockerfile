FROM twdps/di-circleci-remote-docker:2020.05

LABEL maintainer=<nchenewe@thoughtworks.com>

#ENV CONFTEST_VERSION=0.18.2

# sudo since twdps circleci remote docker images set the USER=cirlceci
# hadolint ignore=DL3004
RUN sudo sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories" && \
    sudo apk add --no-cache \
             bash==5.0.11-r1 \
             curl==7.67.0-r0 \
             openssl==1.1.1g-r0 \
             gnupg==2.2.19-r0 \
             docker==19.03.5-r1 \
             openrc==0.42.1-r2 \
             libstdc++==9.2.0-r4 \
             nodejs==12.15.0-r1 \
             npm==12.15.0-r1 \
             jq==1.6_rc1-r1 && \
    sudo apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted \
             secrethub-cli==0.38.0-r0 && \
    sudo npm install -g snyk@1.327.0 && \
    sudo rc-update add docker boot

COPY ./profiles/cis-docker-container /share/profiles/cis-docker-container
COPY ./profiles/cis-docker-image /share/profiles/cis-docker-image
VOLUME ["/share"]

USER cirlceci
HEALTHCHECK NONE
#https://github.com/open-policy-agent/conftest/releases/download/v0.18.2/conftest_0.18.2_Darwin_x86_64.tar.gz
    # sudo wget https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz & \
    # sudo tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && rm conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    # sudo mv conftest /usr/local/bin && \
