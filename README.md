# ups

Sample runs:

```
docker run -it --rm -v ${PWD}:/data -w /data pdf-form add-text "ERTUĞRUL KARTAL TABAK" 10cm 8.3cm 10cm a.pdf a.pdf

docker run -it --rm -v ${PWD}:/data -w /data pdf-form add-graphics imza.png 3cm 26cm 2cm a.pdf a.pdf

```

First one adds the text to the input a.pdf at the mentioned location and writes back to a.pdf. 

Second one adds a graphic to a.pdf

