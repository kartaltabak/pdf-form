#!/bin/bash

IMAGE_DIR="."
OUTPUT_PDF="merged_images.pdf"
RESIZE="40%"

mapfile -t image_files < <(find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

mkdir /tmp/foo
cp * /tmp/foo 

mapfile -t image_files < <(find /tmp/foo -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

if [ ${#image_files[@]} -eq 0 ]; then
    echo "No image files found in $IMAGE_DIR"
    exit 1
fi

mogrify -resize "${RESIZE}" -density 150 /tmp/foo/*.jpg /tmp/foo/*.jpeg /tmp/foo/*.png

img2pdf "${image_files[@]}" --output "$OUTPUT_PDF" --pagesize A4 

echo "PDF created successfully: $OUTPUT_PDF"

