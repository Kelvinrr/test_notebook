FROM andrewosh/binder-base

USER root

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# make sure the package repository is up to date
RUN apt-get update
# install python3 and pip for python3
RUN apt-get install -y python3-pip  

RUN git clone https://github.com/Kelvinrr/autocnet.git $HOME/autocnet && cd $HOME/autocnet

RUN bash miniconda.sh -b -p $HOME/miniconda
RUN export PATH="$HOME/miniconda/bin:$PATH"
RUN echo "export PATH=$PATH:$HOME/miniconda/bin/python3.5" >> ~/.bashrc

RUN hash -r
RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda

# Useful for debugging any issues with conda
RUN conda info -a

# Create a virtual env and install dependencies
# RUN conda create -y -q -n notebook-env python=3.5 nose numpy pillow scipy pandas networkx scikit-image sqlalchemy numexpr dill cython

RUN conda env create -f $HOME/autocnet/environment.yml

# Activate the env
RUN source activate autocnet

# Install the non-conda packages if required, requirements.txt duplicates are ignored
# RUN conda install -c https://conda.anaconda.org/jlaura opencv3=3.0.0
RUN conda install opencv 
RUN conda install -c https://conda.anaconda.org/jlaura h5py gdal
RUN conda install -c osgeo proj4
RUN conda upgrade numpy

RUN pip install -r $HOME/autocnet/requirements_dev.txt
RUN conda install 

