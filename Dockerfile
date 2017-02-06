FROM lambci/lambda:build

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

COPY yum.conf /etc/yum.conf

RUN cd /var/lib && \
    rm -f __db* && \
    rpm --rebuilddb && \
    rpmdb_verify Packages

RUN yum clean all && \
    yum -y install python27-pip python27-devel python27-virtualenv vim postgresql postgresql-devel mysql mysql-devel gcc && \
    pip install -U pip && \
    pip install -U zappa awscli mysql-python

WORKDIR /var/task

RUN virtualenv /var/venv && \
    source /var/venv/bin/activate

COPY bashrc /root/.bashrc

CMD ["zappa"]
