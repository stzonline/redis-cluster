FROM      centos:centos7.1.1503

MAINTAINER stzonline@qq.com

WORKDIR /root

ENV TZ "Asia/Shanghai"

ENV TERM xterm

#ADD aliyun-mirror.repo /etc/yum.repos.d/CentOS-Base.repo
#ADD aliyun-epel.repo /etc/yum.repos.d/epel.repo
ADD Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
ADD epel-7.repo /etc/yum.repos.d/epel.repo

VOLUME ["/root/redissoft"]

RUN yum install -y curl wget tar bzip2 unzip vim-enhanced passwd sudo yum-utils hostname net-tools rsync man && \

    yum install -y gcc gcc-c++ git make automake cmake patch logrotate python-devel libpng-devel libjpeg-devel && \

    yum install -y --enablerepo=epel pwgen python-pip && \

    yum install -y ruby rubygems && \

    yum clean all

RUN yum install -y ruby-devel.x86_64
RUN gem install redis -v 3.0.3

RUN wget http://download.redis.io/releases/redis-3.0.3.tar.gz && \
    tar -xzvf redis-3.0.3.tar.gz && \
    rm -rf redis-3.0.3.tar.gz 

RUN cd /root/redis-3.0.3  && \
make MALLOC=libc && \
make install

ENV PATH=$PATH:/root/redis-3.0.3/src
    
COPY config/7001 /root/config/7001
COPY config/7002 /root/config/7002
COPY config/7003 /root/config/7003
COPY config/7004 /root/config/7004
COPY config/7005 /root/config/7005
COPY config/7006 /root/config/7006

#RUN gem install redis-3.2.1.gem
#http://www.linuxidc.com/Linux/2016-03/129287.htm
   
#docker build -t redis/nodemodule:0.1.0 . 
#docker run -d --name redisNode1 --net=host -v /root/redissoft/7001/data:/root/redissoft/7001/data  redis/nodemodule:0.1.0   /bin/sh -c "redis-server /root/config/7001/redis.conf" 