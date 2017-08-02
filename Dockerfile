FROM lambci/lambda:build

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

ARG region

COPY yum.conf /etc/yum.conf

# Fix for slow yum metadata https://github.com/danielwhatmuff/zappa/issues/4
RUN if ! [[ -z "$region" ]]; then echo $region > /etc/yum/vars/awsregion; fi

RUN yum clean all && \
    yum -y install python27-devel python27-virtualenv vim postgresql postgresql-devel mysql mysql-devel gcc lapack-devel blas-devel libyaml-devel && \
    yum --enablerepo=epel -y install hdf5-devel && \
    pip install -U pip && \
    pip install -U zappa==0.42.2 mysql-python

WORKDIR /var/task

RUN virtualenv /var/venv && \
    source /var/venv/bin/activate && \
    pip install -U pip && \
    deactivate

COPY bashrc /root/.bashrc

CMD ["zappa"]
