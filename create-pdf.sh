#!/bin/zsh

docker run --rm -it \
    -v "${PWD}":"${PWD}" \
    -v "${0:A:h}/Imza.jpg":/Imza.jpg \
    -v "${0:A:h}/Isim.jpg":/Isim.jpg \
    -w "${PWD}" \
    -v "${0:A:h}/fill.props":/fill.props \
    "$(docker build -q "${0:A:h}/docker")" \
    /create-pdf.sh \
    "$@"

