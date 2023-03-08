#!/usr/bin/env bash

set +x

TEXT=$1
WIDTH=$2
POS_Y=$3
POS_X=$4
IN_PDF=$5
OUT_PDF=$6

printf 'TEXT: %s\n' "$TEXT"

TEX_FILE=/home/miktex/document.tex

cat <<EOF > "${TEX_FILE}"
\documentclass[a4paper]{article}

\usepackage[utf8x]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{pdfpages}
\usepackage[absolute,overlay]{textpos}
\usepackage{xcolor}

\usepackage[top=1.3cm, bottom=2.0cm, outer=2.5cm, inner=2.5cm, heightrounded,
marginparwidth=1.5cm, marginparsep=0.4cm, margin=2.5cm]{geometry}

\usepackage{graphicx}

\begin{document}
EOF

printf '\\begin{textblock*}{%s}(%s,%s) \\small {%s} \\end{textblock*}' "$WIDTH" "$POS_X" "$POS_Y" "$TEXT" >> "${TEX_FILE}"
printf '\\includepdf{%s}' "$IN_PDF" >> "${TEX_FILE}"

cat <<EOF >> "${TEX_FILE}"
\end{document}
EOF

cp "$PDF"* /home/miktex
(cd /home/miktex && pdflatex -synctex=1 -interaction=nonstopmode "${TEX_FILE}")

cp /home/miktex/document.pdf "$OUT_PDF"
