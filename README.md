# PDF Form

This project is a simple tool to manipulate PDF files. 

## Add a text to an existing PDF 

This command adds the text to the input a.pdf at the mentioned location and writes back to a.pdf.

```
docker run -it --rm -v ${PWD}:/work -w /work kartaltabak/pdf-form add-text "ERTUĞRUL KARTAL TABAK" 10cm 8.3cm 10cm a.pdf a.pdf
```

## Add a graphic to an existing PDF

This command adds a graphic to a.pdf.

```
docker run -it --rm -v ${PWD}:/work -w /work kartaltabak/pdf-form add-graphics imza.png 3cm 26cm 2cm a.pdf a.pdf
```

## Create a PDF from images

This command creates a PDF from images. The images should be on the same directory with the name 1.png, 2.png, 3.png, etc.
The images are sorted by their names, reduced 40% (best practice for A4) and added to the PDF.
If you want to change the rotation, you may use `--rotate 90` option to rotate 90 degrees clockwise.

```
docker run -it --rm -v ${PWD}:/work -w /work kartaltabak/pdf-form create-pdf-from-images 
```


