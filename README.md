# pdf2pptx
A container for converting PDFs to Powerpoint

Therefore, it packages https://github.com/ashafaei/pdf2pptx into an Alpine based container.

## Starting the container

Mount the volume that contains your pdf files (`$PDF_DIR`) and run the container with

`docker run -v $PDF_DIR:/pdf whatever4711/pdf2pptx your.pdf`
