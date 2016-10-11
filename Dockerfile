FROM alpine:3.4
MAINTAINER smizy

# install conda/jupyter
ENV CONDA_DIR=/opt/conda CONDA_VER=4.0.5
ENV PATH=$CONDA_DIR/bin:$PATH SHELL=/bin/bash LC_ALL=C LANG=C.UTF-8

RUN set -x \
    && apk update \
    && apk --no-cache add \
        bash \
        ca-certificates \
        libstdc++ \
        su-exec \ 
        wget \
    && wget  -O /tmp/glibc.apk "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk"  \
    && wget -q -O /tmp/glibc-bin.apk "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r3/glibc-bin-2.23-r3.apk" \
    && wget -q -O /tmp/glibc-i18n.apk "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r3/glibc-i18n-2.23-r3.apk" \
    && apk add --allow-untrusted /tmp/glibc*.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 C.UTF-8 \
    && rm -rf /tmp/glibc*apk /var/cache/apk/* \
    && mkdir -p $CONDA_DIR \
    && wget -q -O mconda.sh https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VER}-Linux-x86_64.sh \
    && /bin/bash mconda.sh -f -b -p $CONDA_DIR \
    && rm mconda.sh \
    && conda install --yes \
        ipywidgets \
        'notebook=4.0*' \
        pandas \
        scikit-learn \
        terminado \
    && pip install pip --upgrade \
    && pip install jupyter-console \
    && conda clean --yes --tarballs --packages --source-cache \     
    && find /opt -name __pycache__ | xargs rm -r \
    && rm -rf \
        /opt/conda/pkgs/* \
        /root/.[acpw]* \
    && apk --no-cache add \
        tini 

WORKDIR /code

COPY entrypoint.sh  /usr/local/bin/
COPY jupyter_notebook_config.py ./

EXPOSE 8888

ENTRYPOINT ["tini", "--", "entrypoint.sh"]
CMD ["jupyter", "notebook"]