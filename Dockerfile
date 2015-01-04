FROM centos
MAINTAINER Dave Johnston email: dave.johnston@icloud.com
WORKDIR /tmp

# Install Apache Web Server
RUN yum install -y httpd; yum clean all

RUN yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

# Docker automatically extracted. So move files to web directory
RUN yum install -y createrepo xorriso wget

RUN mkdir -p /var/www/html/centos/6.5 \
 && wget http://mirror.simwood.com/centos/6.6/isos/x86_64/CentOS-6.6-x86_64-minimal.iso

RUN osirrox -indev /tmp/CentOS-6.6-x86_64-minimal.iso -extract /Packages /var/www/html/centos/6.5/ \
 && cd /var/www/html/centos/ \
 && createrepo .

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD [ "-D", "FOREGROUND" ]
