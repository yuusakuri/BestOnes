FROM php:7.4-fpm-alpine

COPY ./php/php.ini /usr/local/etc/php/
COPY ./php/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf

WORKDIR /var/www/html

RUN apk update && apk add --no-cache \
  # npm(with nodejs)
  npm

RUN docker-php-ext-install \
  pdo \
  pdo_mysql

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin
