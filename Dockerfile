FROM lambci/lambda:build

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

RUN yum clean all && \
    yum -y install python27-pip python27-dev python27-virtualenv vim mysql mysql-devel gcc && \
    pip install -U pip zappa mysql-python awscli

WORKDIR /var/task

CMD ["zappa"]
