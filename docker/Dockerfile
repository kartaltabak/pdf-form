FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC+3

RUN apt-get update && \
    apt-get install -y gnupg ca-certificates && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 && \
    (echo "deb http://miktex.org/download/ubuntu focal universe" > /etc/apt/sources.list.d/miktex.list ) && \
    apt-get update && \
    apt-get install -y miktex && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    miktexsetup --shared=yes finish && \
    initexmf --admin --set-config-value [MPM]AutoInstall=1 && \
    mpm --admin --update

RUN useradd --system --create-home --home-dir /home/miktex --shell /bin/bash -g root -G sudo -u 1001 miktex
USER miktex
WORKDIR /home/miktex
RUN mpm --update

COPY add-text.sh /usr/local/sbin/add-text
COPY add-graphics.sh /usr/local/sbin/add-graphics
COPY blank.pdf /
COPY empty.png /

RUN add-text x 1cm 2cm 3cm blank out && \
    rm -rf document* && \
    rm -rf out*

RUN add-graphics empty.png 1cm 2cm 3cm blank out && \
    rm -rf document* && \
    rm -rf out*