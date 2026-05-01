ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
    apt-get install -y \
      gnupg \
      ca-certificates \
      perl-tk \
      ghostscript \
      imagemagick \
      img2pdf

RUN mkdir -p /usr/share/keyrings && \
    gpg --batch --keyserver hkps://keyserver.ubuntu.com --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 && \
    gpg --batch --yes --export D6BC243565B2087BC3F897C9277A7293F59E4889 > /usr/share/keyrings/miktex.gpg && \
    . /etc/lsb-release && \
    echo "deb [signed-by=/usr/share/keyrings/miktex.gpg] http://miktex.org/download/ubuntu ${DISTRIB_CODENAME} universe" > /etc/apt/sources.list.d/miktex.list

RUN apt-get update && \
    apt-get install -y miktex && \
    miktexsetup --shared=yes finish && \
    initexmf --admin --set-config-value [MPM]AutoInstall=1 && \
    mpm --admin --update

RUN useradd --system --create-home --home-dir /home/miktex --shell /bin/bash -g root -G sudo -u 1001 miktex
USER miktex
WORKDIR /home/miktex
RUN mpm --update

COPY add-text.sh /usr/local/sbin/add-text
COPY add-graphics.sh /usr/local/sbin/add-graphics
COPY create-pdf-from-images.sh /usr/local/sbin/create-pdf-from-images
COPY extract-images-from-pdf.sh /usr/local/sbin/extract-images-from-pdf
COPY blank.pdf /
COPY empty.png /

RUN add-text x 1cm 2cm 3cm blank out && \
    rm -rf document* && \
    rm -rf out* && \
    add-graphics /empty.png 1cm 2cm 3cm blank out && \
    rm -rf document* && \
    rm -rf out*

COPY sample.tex /home/miktex/sample.tex

RUN cd /home/miktex/ && \
    pdflatex -interaction=nonstopmode -output-format=pdf sample.tex

USER root
RUN rm -rf /blank.pdf && \
    rm -rf /empty.png && \
    rm -rf /home/miktex/sample.*

RUN usermod -u 1002 ubuntu && \
    groupmod -g 1002 ubuntu && \
    useradd --home-dir /home/jenkins --create-home --shell /bin/bash --uid 1000 jenkins

USER miktex
