FROM andrewosh/binder-base

USER root

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# make sure the package repository is up to date
RUN apt-get update
# install python3 and pip for python3
RUN apt-get install -y python3-pip  

# RUN git clone https://github.com/Kelvinrr/autocnet.git $HOME/autocnet

RUN bash miniconda.sh -b -p $HOME/miniconda
RUN export PATH="$HOME/miniconda/bin:$PATH"
RUN echo "export PATH=$PATH:$HOME/miniconda/bin/python3.5" >> ~/.bashrc

RUN hash -r
RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda

# Useful for debugging any issues with conda
RUN conda info -a

RUN wget https://raw.githubusercontent.com/Kelvinrr/test_notebook/master/environment.yml -O $HOME/environment.yml
RUN conda create -y -q -n autocnet -f $HOME/environment.yml
RUN rm $HOME/environment.yml

# Activate the env
RUN source activate autocnet

# Install the non-conda packages if required, requirements.txt duplicates are ignored
RUN conda install -c https://conda.anaconda.org/jlaura opencv3=3.0.0
RUN conda upgrade numpy

RUN pip install -r $HOME/autocnet/requirements.txt

