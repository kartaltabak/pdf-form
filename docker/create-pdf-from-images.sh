#!/bin/bash

IMAGE_DIR="."
OUTPUT_PDF="merged_images.pdf"
DEFAULT_RESIZE="40%"
RESIZE="$DEFAULT_RESIZE"
ADDITIONAL_ARGS=()

if [[ $1 =~ ^[0-9]+%$ ]]; then
    RESIZE="$1"
    shift
fi

ADDITIONAL_ARGS=("$@")

mkdir -p /tmp/foo
cp ./* /tmp/foo

mapfile -t image_files < <(find /tmp/foo -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

if [ ${#image_files[@]} -eq 0 ]; then
    echo "No image files found in ${IMAGE_DIR}"
    exit 1
fi

mogrify -resize "${RESIZE}" -density 150 /tmp/foo/*.jpg /tmp/foo/*.jpeg /tmp/foo/*.png

img2pdf "${image_files[@]}" --output "${OUTPUT_PDF}" --pagesize A4 "${ADDITIONAL_ARGS[@]}"

echo "PDF created successfully: ${OUTPUT_PDF}"

