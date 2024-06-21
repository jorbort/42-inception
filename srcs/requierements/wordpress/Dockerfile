FROM debian:11.9

ENV DEBIAN_FRONTEND=noninteractive

# Install PHP and dependencies
RUN apt-get update -y && apt-get upgrade -y && apt-get -y install \
    php-fpm \
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

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Create PHP run directory
RUN mkdir /run/php

# Copy the setup script
COPY ./tool/set_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/set_wordpress.sh

# Set the entrypoint to the setup script
ENTRYPOINT ["/usr/local/bin/set_wordpress.sh"]

# Set the working directory
WORKDIR /var/www/html/

# Expose the port for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.4", "-F"]