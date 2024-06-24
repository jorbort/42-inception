FROM debian:11.9

EXPOSE 9000

RUN apt-get update -y && \
	apt-get install -y curl php7.4-mysql php7.4-fpm

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update -y && \
    apt-get install -y curl php7.4-mysql php7.4-fpm netcat

RUN mkdir -p /run/php
RUN chmod 755 /run/php

COPY ./tools/wordpress_start.sh /etc
RUN chmod a+x /etc/wordpress_start.sh

WORKDIR /var/www/html

ENTRYPOINT ["/etc/wordpress_start.sh"]