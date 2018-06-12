FROM php:cli

RUN apt-get update -yqq && \
    apt-get install -yqq \
        git \
        libmcrypt-dev \
        libpq-dev \
        libcurl4-gnutls-dev \
        libicu-dev \
        libvpx-dev \
        libjpeg-dev \
        libpng-dev \
        libxpm-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libxml2-dev \
        libexpat1-dev \
        libbz2-dev \
        libgmp3-dev \
        libldap2-dev \
        unixodbc-dev \
        libsqlite3-dev \
        libaspell-dev \
        libsnmp-dev \
        libpcre3-dev \
        libtidy-dev \
        libssh2-1 \
        libssh2-1-dev \
        libmemcached-dev \
        python \
        python-pip && \
    pecl install ssh2-1.0 memcached && \
    echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini && \
    docker-php-ext-install mbstring pdo_pgsql curl json intl gd xml zip bz2 opcache pdo pdo_mysql && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python

COPY composer_install.sh /
RUN apt-get install -y wget && \
    chmod a+x composer_install.sh && \
    ./composer_install.sh

RUN apt-get update && apt-get install -my gnupg && \
    curl -sL https://deb.nodesource.com/setup_9.x | bash && \
    apt-get update -yqq && \
    apt-get install build-essential nodejs -yqq && \
    pip install awsebcli