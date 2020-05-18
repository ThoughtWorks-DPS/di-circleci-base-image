FROM cimg/base:2020.05

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
        gcc==9.2.0-r4 \
        g++==9.2.0-r4 \
        python3==3.8.2-r0 \
        build-base==0.5-r1 \
        musl-dev==1.1.24-r2 \
        libc-dev==0.7.2-r0 \
        libffi-dev==3.2.1-r6 \
        openssl-dev==1.1.1g-r0 \
        python3-dev==3.8.2-r0 \
        make==4.2.1-r2 \
        jq==1.6_rc1-r1 && \
    apk add --no-cache --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli==0.38.0-r0 && \
    rc-update add docker boot && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip==20.1 && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    ln -s /usr/bin/pydoc3 /usr/bin/pydoc && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/python3-config /usr/bin/python-config && \
    pip install \
        setuptools==41.2.0 \
        invoke==1.4.1 \
        pylint==2.5.2 \
        yamllint==1.23.0 \
        datadog==0.36.0 \
        hvac==0.10.1 \
        jinja2==2.11.2 \
        requests==2.23.0 \
        awscli==1.18.61

USER circleci
HEALTHCHECK NONE
