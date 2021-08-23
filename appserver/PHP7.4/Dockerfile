FROM php:7.4-fpm-alpine
RUN set -eux; \
  \
  apk add --no-cache --virtual .build-deps \
  coreutils \
  freetype-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  libzip-dev \
  postgresql-dev \
  ; \
  \
  docker-php-ext-configure gd \
  --with-freetype \
  --with-jpeg=/usr/include \
  ; \
  \
  docker-php-ext-install -j "$(nproc)" \
  gd \
  opcache \
  pdo_mysql \
  pdo_pgsql \
  zip \
  ;

COPY config/opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini


FROM nginx:mainline-alpine
