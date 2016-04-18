FROM andrewosh/binder-base

USER root

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN bash miniconda.sh -b -p $HOME/miniconda
ENV PATH $HOME/anaconda/bin:$PATH

# Create a virtual env and install dependencies
RUN conda create -y -q -n notebook-env python=3.5 nose numpy pillow scipy pandas networkx scikit-image sqlalchemy numexpr dill cython
# Activate the env
RUN source activate notebook-env

# Install the non-conda packages if required, requirements.txt duplicates are ignored
RUN conda install -c https://conda.anaconda.org/jlaura opencv3=3.0.0
RUN conda install -c https://conda.anaconda.org/jlaura h5py gdal
RUN conda install -c osgeo proj4
RUN conda upgrade numpy
RUN pip install -r requirements.txt


