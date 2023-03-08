#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Usage <AMAZON_ORDER_NO> <UPS PDF>"
    echo "Example: 111-0612879-6119448 UPS.pdf"
    exit;
fi

AMAZON_ORDER_NO=$1
UPS_PDF=$2
SIGN_DAY=$(date '+%d')
SIGN_MONTH=$(date '+%m')
SIGN_YEAR=$(date -d "$D" '+%y')

source /fill.props &&
  sed \
    --expression="s/{{NAME}}/$NAME/g" \
    --expression="s.{{ADDRESS}}.$ADDRESS.g" \
    --expression="s/{{PHONE}}/$PHONE/g" \
    --expression="s/{{EMAIL}}/$EMAIL/g" \
    --expression="s/{{TCKNO}}/$TCKNO/g" \
    --expression="s/{{AMAZON_ORDER_NO}}/$AMAZON_ORDER_NO/g" \
    --expression="s/{{SIGN_DAY}}/$SIGN_DAY/g" \
    --expression="s/{{SIGN_MONTH}}/$SIGN_MONTH/g" \
    --expression="s/{{SIGN_YEAR}}/$SIGN_YEAR/g" \
      /template.tex \
      > /home/miktex/a.tex &&
  cp "$UPS_PDF" /home/miktex/UPS.pdf &&
  cp /Imza.jpg /home/miktex/ &&
  cp /Isim.jpg /home/miktex/ &&
  (cd /home/miktex && pdflatex -synctex=1 -interaction=nonstopmode /home/miktex/a.tex ) &&
  cp /home/miktex/a.pdf a.pdf

