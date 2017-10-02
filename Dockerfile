FROM lambci/lambda:build

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

ARG region

COPY yum.conf /etc/yum.conf

# Fix for slow yum metadata https://github.com/danielwhatmuff/zappa/issues/4
RUN if ! [[ -z "$region" ]]; then echo $region > /etc/yum/vars/awsregion; fi

RUN yum clean all && \
    yum -y install virtualenv vim postgresql postgresql-devel mysql mysql-devel gcc lapack-devel blas-devel libyaml-devel wget && \
    cd /usr/src && \
    wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz && \
    tar xzf Python-3.6.1.tgz && \
    rm -f Python-3.6.1.tgz && \
    cd Python-3.6.1 && \
    ./configure && \
    make && \
    make install && \
    rm -rf /usr/src/Python-3.6.1 && \
    cd && \
    python -v

RUN ln -s /usr/local/bin/pip3.6 /usr/local/bin/pip && \
    pip install -U pip zappa

WORKDIR /var/task

RUN python3 -m venv /var/venv && \
    source /var/venv/bin/activate && \
    pip install -U pip && \
    deactivate

COPY bashrc /root/.bashrc

CMD ["zappa"]
