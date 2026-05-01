ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
    apt-get install -y \
      gnupg \
      ca-certificates \
      curl \
      perl-tk \
      ghostscript \
      imagemagick \
      img2pdf \
      poppler-utils

RUN mkdir -p /usr/share/keyrings && \
    curl -fsSL https://miktex.org/download/key | gpg --dearmor -o /usr/share/keyrings/miktex.gpg && \
    . /etc/lsb-release && \
    echo "deb [signed-by=/usr/share/keyrings/miktex.gpg] https://miktex.org/download/ubuntu ${DISTRIB_CODENAME} universe" > /etc/apt/sources.list.d/miktex.list

RUN apt-get update && \
    apt-get install -y miktex && \
    miktexsetup --shared=yes finish && \
    initexmf --admin --set-config-value [MPM]AutoInstall=1 && \
    mpm --admin --update

ARG MIKTEX_USER_HOME=/home/miktex
RUN useradd --create-home --home-dir ${MIKTEX_USER_HOME} --shell /bin/bash --uid 1001 miktex

USER miktex
WORKDIR ${MIKTEX_USER_HOME}
RUN mpm --update

COPY add-text.sh /usr/local/sbin/add-text
COPY add-graphics.sh /usr/local/sbin/add-graphics
COPY create-pdf-from-images.sh /usr/local/sbin/create-pdf-from-images
COPY extract-images-from-pdf.sh /usr/local/sbin/extract-images-from-pdf
COPY blank.pdf ${MIKTEX_USER_HOME}
COPY empty.png ${MIKTEX_USER_HOME}

RUN add-text x 1cm 2cm 3cm /blank.pdf out && \
    rm -rf document* && \
    rm -rf out* && \
    add-graphics /empty.png 1cm 2cm 3cm /blank.pdf out && \
    rm -rf document* && \
    rm -rf out*

COPY sample.tex ${MIKTEX_USER_HOME}/sample.tex

RUN pdflatex -interaction=nonstopmode -output-format=pdf sample.tex

USER root
RUN rm -rf ${MIKTEX_USER_HOME}/blank.pdf && \
    rm -rf ${MIKTEX_USER_HOME}/empty.png && \
    rm -rf ${MIKTEX_USER_HOME}/sample.*

USER miktex
