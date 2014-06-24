FROM ubuntu:14.04
MAINTAINER Scott Powers <spowers.42@gmail.com>

RUN apt-get update 

RUN apt-get install -y python-dev libfreetype6-dev pkg-config libhdf5-dev wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential python-dev python-pip liblapack-dev libatlas-dev gfortran libfreetype6 libfreetype6-dev libpng12-dev python-lxml libyaml-dev g++ libffi-dev


#0MQ
RUN cd /tmp && \
    wget http://download.zeromq.org/zeromq-4.0.3.tar.gz && \
    tar xvfz zeromq-4.0.3.tar.gz && \
    cd zeromq-4.0.3 && \
    ./configure && \
    make install && \
    ldconfig

RUN pip install -U pip
RUN pip install -U distribute
RUN pip install freetype-py
RUN pip install ipython

#Data analysis packages
RUN pip install numpy
RUN pip install pandas
RUN pip install pandasql
RUN pip install networkx
RUN pip install biopython
RUN pip install scikit-learn

#plotting
RUN pip install seaborn
RUN pip install matplotlib

#optimization
RUN pip install cython
RUN pip install numba

#io
RUN pip install h5py
RUN pip install pyyaml

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888 --pylab=inline
