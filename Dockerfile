FROM centos:centos7

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install -y make git gcc gcc-c++ glibc-devel.i686 libstdc++-devel.i686

WORKDIR /app

COPY . /app

RUN CPATH=$CPATH:/usr/include/c++/4.8.5/i686-redhat-linux CFG=$CONFIGURATION make -C dlls

RUN mkdir -p /output && cp dlls/ag_i386.so /output/ag.so

ENTRYPOINT ["sh", "-c", "cp /output/ag.so /mnt/output/ag.so"]