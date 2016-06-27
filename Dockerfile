FROM c12e/alpine-jupyter-minimal

RUN set -x \
    && conda install -y \
      h5py \
      matplotlib \
      markdown \
      pandas \
      pillow \
      pip \
      scikit-learn \
      scipy \
      seaborn \
      theano \
    && pip install --upgrade -I setuptools \
    && pip install --upgrade \
      chainer \
      keras \
      https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp35-cp35m-linux_x86_64.whl \
    && conda clean --yes --tarballs --packages --source-cache \     
    && find /opt -name __pycache__ | xargs rm -r \
    && rm -rf \
        /opt/conda/pkgs/* \
        /root/.[acpw]* 

  
# RUN wget -q -O /tmp/noto.zip https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
#     && cd /tmp/ \
#     && unzip noto.zip \
#     && mv *.otf /opt/conda/lib/python3.5/site-packages/matplotlib/mpl-data/fonts/ttf/ \
#     && rm /tmp/noto.zip 