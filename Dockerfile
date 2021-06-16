FROM rapidsai/rapidsai:0.19-cuda11.0-runtime-ubuntu18.04-py3.8

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing && \
  apt-get install -y wget bzip2 build-essential \
  ca-certificates git libglib2.0-0 libxext6 libsm6 \
  libxrender1 git mercurial subversion python3-dev && \
  apt-get clean

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
  jupyterlab \
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