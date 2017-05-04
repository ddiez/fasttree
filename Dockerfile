FROM debian:testing

LABEL maintainer Diego Diez <diego10ruiz@gmail.com>

RUN apt-get update -y && \
    apt-get install -y \
      gcc \
      curl \
      && \
    curl http://www.microbesonline.org/fasttree/FastTree.c > /tmp/FastTree.c && \
    cd /tmp && \
    gcc -DNO_SSE -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm && \
    mkdir /opt/bin && \
    cp /tmp/FastTree /opt/bin/FastTree && \

    apt-get purge -y \
      gcc \
      curl \
      && \
    apt-get autoremove -y

ENV PATH /opt/bin:$PATH

RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev

CMD ["/bin/bash"]
