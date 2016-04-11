FROM andrewosh/binder-base

Run bash miniconda.sh -b -p $HOME/miniconda
Run export PATH="$HOME/miniconda/bin:$PATH"
Run hash -r
RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda
  # Useful for debugging any issues with conda
RUN conda info -a

  # Create a virtual env and install dependencies
RUN conda create -y -q -n test-env python=$TRAVIS_PYTHON_VERSION nose numpy pillow scipy pandas networkx scikit-image sqlalchemy numexpr dill cython
  # Activate the env
RUN source activate test-env

  # Install the non-conda packages if required, requirements.txt duplicates are ignored
RUN conda install -c https://conda.anaconda.org/jlaura opencv3=3.0.0
RUN conda install -c https://conda.anaconda.org/jlaura h5py gdal
RUN conda install -c osgeo proj4
RUN conda upgrade numpy
RUN pip install -r requirements.txt
RUN pip install coverage
RUN pip install coveralls



