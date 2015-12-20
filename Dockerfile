FROM centos:centos7

RUN yum install java-1.8.0-openjdk  curl -y
#ENV JAVA_HOME /usr/lib/jvm/default-java/jre

## 5555 - Riemann TCP and UDP; 5556 - Riemann websocket
EXPOSE 5555 5555/udp 5556
CMD ["/usr/bin/riemann"]
RUN yum -y install \
http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo && 
RUN yum -y --enablerepo=epel 
RUN yum --nogpgcheck localinstall https://aphyr.com/riemann/riemann-0.2.10-1.noarch.rpm

RUN curl -so /tmp/riemann.deb https://aphyr.com/riemann/riemann_0.2.10_all.deb && dpkg -i /tmp/riemann.deb && rm -f /tmp/riemann.deb
ADD riemann.config /etc/riemann/
