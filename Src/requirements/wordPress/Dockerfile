FROM debian:11.9

RUN apt-get update -y && apt-get upgrade -y && apt-get install php-fpm \
    wget \
    php-fpm \
    php-mysql \
    php-xml \
    php-gd \ 
    php-curl \
    php-zip \
    php-mbstring \
    curl \ 
    unzip \
    && apt-get clean 

RUN curl -o