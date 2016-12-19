FROM amazonlinux

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

RUN yum clean all && \
    yum -y install python27-pip python27-dev && \
    pip install -U pip wheel zappa

CMD ["zappa"]
