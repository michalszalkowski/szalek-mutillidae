FROM ubuntu:15.04
MAINTAINER szalek <szalek@btbw.pl>

RUN apt-get update
RUN apt-get install -y apache2 apache2-utils \
 libapache2-mod-auth-mysql php5-mysql php5 \
 php-pear php5-gd php5-mcrypt php5-curl \
 unzip curl vim dnsutils

COPY ./mutillidae-2.6.48.zip /tmp/mutillidae-2.6.48.zip
RUN cd /var/www/html && unzip /tmp/mutillidae-2.6.48.zip

RUN export DEBIAN_FRONTEND="noninteractive"; \
   echo "mysql-server-5.6 mysql-server/root_password password" | debconf-set-selections; \
   echo "mysql-server-5.6 mysql-server/root_password_again password" | debconf-set-selections; \
   apt-get install -y mysql-server-5.6

COPY ./run.sh /run.sh

RUN echo "/mutillidae" > /var/www/html/index.html
RUN /bin/sed -i -e "s/allow_url_include = Off/allow_url_include = On/g" /etc/php5/apache2/php.ini

EXPOSE 80
CMD ["/bin/sh", "/run.sh"]