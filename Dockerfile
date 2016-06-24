FROM c12e/alpine-jupyter-minimal

RUN conda install -y \
      matplotlib \
      markdown \
      pandas \
      seaborn \
    && find /opt -name __pycache__ | xargs rm -r \
    && rm -rf /opt/conda/pkgs/* 
      
# RUN wget -q -O /tmp/noto.zip https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
#     && cd /tmp/ \
#     && unzip noto.zip \
#     && mv *.otf /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data/fonts/ttf/ \
#     && rm /tmp/noto.zip 