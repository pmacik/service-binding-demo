FROM centos:7
MAINTAINER Pavel Macík <pavel.macik@gmail.com>
RUN yum install epel-release -y
RUN yum install --enablerepo=centosplus -y \
    python36 python36-devel python36-pip postgresql-devel gcc \
    && yum clean all
ADD run.sh /run.sh
ENV LANG=en_US.utf8
ENTRYPOINT [ "/run.sh" ]
