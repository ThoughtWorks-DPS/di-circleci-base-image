FROM twdps/di-circleci-remote-docker:2020.05

LABEL maintainer=<nchenewe@thoughtworks.com>

# set USER to root to install and configure packages
USER root
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories && \
    apk add --no-cache \
        bash==5.0.11-r1 \
        curl==7.67.0-r0 \
        openssl==1.1.1g-r0 \
        gnupg==2.2.19-r0 \
        docker==19.03.5-r1 \
        openrc==0.42.1-r2 \
        jq==1.6_rc1-r1 && \
    apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted \
        secrethub-cli==0.38.0-r0 && \
    rc-update add docker boot
   
USER circleci
HEALTHCHECK NONE
