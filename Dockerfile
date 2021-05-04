FROM alpine

RUN apk add -U --no-cache git bash imagemagick zip sed && \
    sed -i "s#root:x:0:0:root:/root:/bin/ash#root:x:0:0:root:/root:/bin/bash#g" /etc/passwd && \
    git clone https://github.com/ashafaei/pdf2pptx.git

ENV PATH="/pdf2pptx:$PATH"

WORKDIR pdf

VOLUME pdf

ENTRYPOINT ["pdf2pptx.sh"]

CMD ["/pdf2pptx/test.pdf"]

LABEL de.whatever4711.pdf2pptx.name="PDF2PPTX" \
    de.whatever4711.pdf2pptx.docker.cmd="docker run -v $PDF_DIR:/pdf whatever4711/pdf2pptx your.pdf" \
    de.whatever4711.pdf2pptx.vendor="Marcel Grossmann"
