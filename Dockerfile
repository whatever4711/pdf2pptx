FROM alpine
ARG TARGETPLATFORM=amd64
ARG VERSION=1.0
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

RUN apk add --no-cache bash
RUN apk add --no-cache git imagemagick zip sed && \
    sed -i "s#root:x:0:0:root:/root:/bin/ash#root:x:0:0:root:/root:/bin/bash#g" /etc/passwd && \
    git clone https://github.com/ashafaei/pdf2pptx.git

ENV PATH="/pdf2pptx:$PATH"

WORKDIR pdf

VOLUME pdf

ENTRYPOINT ["pdf2pptx.sh"]

CMD ["/pdf2pptx/test.pdf"]

LABEL de.uniba.ktr.prometheus.version=$VERSION \
      de.uniba.ktr.prometheus.name="PDF2PPTX" \
      de.uniba.ktr.prometheus.docker.cmd="docker run -v $PDF_DIR:/pdf whatever4711/pdf2pptx your.pdf" \
      de.uniba.ktr.prometheus.vendor="Marcel Grossmann" \
      de.uniba.ktr.prometheus.architecture=$TARGETPLATFORM \
      de.uniba.ktr.prometheus.vcs-ref=$VCS_REF \
      de.uniba.ktr.prometheus.vcs-url=$VCS_URL \
      de.uniba.ktr.prometheus.build-date=$BUILD_DATE
