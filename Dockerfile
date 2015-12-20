#FROM centos:centos7
FROM riemann-base:latest
#RUN yum install java-1.8.0-openjdk  curl tar bzip2 -y
#ENV JAVA_HOME /usr/lib/jvm/default-java/jre

## 5555 - Riemann TCP and UDP; 5556 - Riemann websocket
EXPOSE 5555 5555/udp 5556

#RUN yum -y install \
#http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
#run yum install -y https://kojipkgs.fedoraproject.org//work/tasks/4028/8784028/daemonize-1.7.3-7.el7.x86_64.rpm
#RUN yum -y --enablerepo=epel 
#RUN yum --nogpgcheck localinstall https://aphyr.com/riemann/riemann-0.2.10-1.noarch.rpm

RUN curl  https://aphyr.com/riemann/riemann-0.2.10.tar.bz2   -o /tmp/rieman.tar.bz2; tar jxvf /tmp/riemann-0.2.10.tar.bz2 -C /opt/ ; chmod -R 777 /opt/riemann-0.2.10
ADD riemann.config /opt/riemann/etc/riemann.config
CMD ["/opt/bin/riemann", "riemann.config"]
