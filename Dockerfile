FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing && \
  apt-get install -y wget bzip2 build-essential \
  ca-certificates git libglib2.0-0 libxext6 libsm6 \
  libxrender1 git mercurial subversion python3-dev && \
  apt-get clean

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
  /bin/bash ~/miniconda.sh -b -p /opt/conda && \
  rm ~/miniconda.sh && \
  /opt/conda/bin/conda clean -tipsy && \
  ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
  echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
  echo "conda activate base" >> ~/.bashrc && \
  find /opt/conda/ -follow -type f -name '*.a' -delete && \
  find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
  /opt/conda/bin/conda clean -afy

ENV PATH=/opt/conda/bin:$PATH

# install mamba
RUN conda install -n base -c conda-forge mamba

RUN mamba install -c conda-forge -n base \
  requests \
  tensorboard \
  tensorboard-plugin-wit \
  tensorflow-base \
  tensorflow-gpu \
  pip \
  setuptools \
  jupyter \
  numba \
  tbb

RUN pip install \
    prompt-toolkit \
    humanize \
    matplotlib \
    natsort \
    pandas \
    psycopg2-binary \
    pyinquirer \
    python-chess==1.2.0 \
    pytz \
    regex \
    scikit-learn \
    seaborn \
    sqlalchemy \
    tensorboardx \
    tensorflow \
    tensorflow-probability \
    PyYAML

COPY /entrypoint.sh /opt/conda/bin/entrypoint.sh
RUN chmod a+x /opt/conda/bin/entrypoint.sh

#ENTRYPOINT ["/opt/conda/bin/entrypoint.sh"]
CMD [".", "/opt/conda/bin/entrypoint.sh"]