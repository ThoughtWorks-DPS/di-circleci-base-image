FROM twdps/di-circleci-remote-docker:2020.05

LABEL maintainer=<nchenewe@thoughtworks.com>

# sudo since twdps circleci remote docker images set the USER=cirlceci

#RUN sudo sh -c "echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories" && \#
# hadolint ignore=DL3004
RUN sudo apk add --no-cache \
             bash==5.0.11-r1 \
             curl==7.67.0-r0 \
             openssl==1.1.1g-r0 \
             gnupg==2.2.19-r0 \
             docker==19.03.5-r1 \
             openrc==0.42.1-r2 \
             jq==1.6-r0 && \
    sudo apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted \
             secrethub-cli==0.38.0-r0 && \
    sudo rc-update add docker boot

HEALTHCHECK NONE
