FROM debian:11.9

RUN apt-get update -y && apt-get upgrade -y && apt-get install php-fpm \
    wget \
    php-mysql \
    php-xml \
    php-gd \
    php-curl \
    php-zip \
    php-mbstring \
    curl \
    unzip \
    && apt-get clean && \
	rm -rf /var/lib/apt/lists/*



RUN chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir /run/php
COPY ./tools/set_wordpress_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/set_wordpress.sh

ENTRYPOINT [ "/usr/local/bin/set_wordpress.sh" ]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]