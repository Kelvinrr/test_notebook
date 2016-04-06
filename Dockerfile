FROM andrewosh/binder-base

USER root

RUN git clone https://github.com/Kelvinrr/autocnet.git
RUN cd autocnet

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
RUN bash miniconda.sh -b -p $HOME/miniconda
RUN export PATH="$HOME/miniconda/bin:$PATH"
RUN hash -r
RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda

RUN conda install nose numpy pillow scipy pandas networkx scikit-image sqlalchemy numexpr dill cython

RUN conda install -c https://conda.anaconda.org/jlaura opencv3=3.0.0
RUN conda install -c https://conda.anaconda.org/jlaura h5py gdal
RUN conda install -c osgeo proj4
RUN conda upgrade numpy

RUN pip install -r requirements.txt
RUN pip install coverage
RUN pip install coveralls



