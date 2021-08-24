FROM php:7.4-fpm-alpine
RUN set -eux; \
  \
  apk add --no-cache --virtual .build-deps \
  coreutils \
  freetype-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  libzip-dev \
  nginx \
  oniguruma-dev \
  openssl \
  postgresql-dev \
  vim \
  ; \
  \
  docker-php-ext-configure gd \
  --with-freetype \
  --with-jpeg=/usr/include \
  ; \
  \
  docker-php-ext-install -j "$(nproc)" \
  gd \
  intl \
  mbstring \
  opcache \
  pdo_mysql \
  pdo_pgsql \
  zip \
  ; \
  \
  docker-php-ext-enable \
  gd \
  intl \
  mbstring \
  opcache \
  ;

COPY 8.0/conf/php/core.php.ini /usr/local/etc/php/conf.d/core-opcache.ini
COPY 8.0/conf/php/opcache.php.ini /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN mkdir /app
RUN chown www-data:www-data /app

COPY 8.0/conf/nginx/default.vhost.conf /etc/nginx/conf.d/default.conf
COPY 8.0/conf/nginx/default.nginx.conf /etc/nginx/nginx.conf

# Certbot
RUN apk upgrade --update-cache --available \
  ; \
  apk add openssl

WORKDIR /certs

RUN openssl req -newkey rsa:2048 -nodes -keyout cert.key \
  -x509 -days 365 -out cert.crt \
  -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

COPY 8.0/conf/nginx/renew /etc/periodic/daily/renew
RUN chmod +x /etc/periodic/daily/renew

WORKDIR /app

# Entrypoint
COPY 8.0/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "../entrypoint.sh" ]

