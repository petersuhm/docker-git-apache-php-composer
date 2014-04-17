FROM ubuntu:precise

MAINTAINER petersuhm

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y git-core curl apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl
RUN a2enmod php5
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer

ADD apache-config.conf /etc/apache2/sites-enabled/000-default

EXPOSE 80

# Manually set the apache environment variables in order to get apache to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Execute the apache daemon in the foreground so we can treat the container as an
# executeable and it wont immediately return.
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
