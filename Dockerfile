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
    docker-php-ext-install mbstring pdo_pgsql curl json intl gd xml zip bz2 opcache pdo pdo_mysql soap && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python

RUN apt-get update && apt-get install -my gnupg wget && \
    curl -sL https://deb.nodesource.com/setup_9.x | bash && \
    apt-get update -yqq && \
    apt-get install build-essential nodejs -yqq && \
    pip install awsebcli && \
    pip install awscli && \
    pip install --upgrade awsebcli && \
    pip install --upgrade awscli

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=bin --filename=composer && \
    php -r "unlink('composer-setup.php');"