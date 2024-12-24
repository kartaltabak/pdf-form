#!/bin/bash

# Exit on error
set -e

# Check for required input
if [ $# -lt 1 ]; then
    echo "Usage: $0 <input-pdf> [resolution] [output-prefix]"
    echo "Example: $0 input.pdf 300 output"
    exit 1
fi

# Input arguments
INPUT_PDF="$1"
RESOLUTION="${2:-300}"  # Default to 300 DPI if not specified
OUTPUT_PREFIX="${3:-output}"  # Default prefix is 'output'

# Check if the input file exists
if [ ! -f "$INPUT_PDF" ]; then
    echo "Error: Input file '$INPUT_PDF' does not exist."
    exit 2
fi

# Process PDF with Ghostscript
echo "Processing PDF '$INPUT_PDF' at resolution $RESOLUTION DPI..."
gs -dSAFER -dBATCH -dNOPAUSE \
   -sDEVICE=pngalpha \
   -r"$RESOLUTION" \
   -sOutputFile="${OUTPUT_PREFIX}-%03d.png" \
   "$INPUT_PDF"

echo "PDF pages have been successfully converted to images with prefix '${OUTPUT_PREFIX}'."
