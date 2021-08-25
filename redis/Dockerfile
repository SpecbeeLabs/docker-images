FROM alpine:3.14
RUN addgroup -S -g 1000 redis && adduser -S -G redis -u 999 redis
RUN apk add --no-cache \
  tzdata

RUN set -eux; \
  \
  apk add --no-cache --virtual .build-deps \
  coreutils \
  dpkg-dev dpkg \
  gcc \
  linux-headers \
  make \
  musl-dev \
  openssl-dev \
  wget \
  ; \
  \
  wget -O redis.tar.gz http://download.redis.io/redis-stable.tar.gz; \
  mkdir -p /tmp/redis; \
  tar -xzf redis.tar.gz -C /tmp/redis --strip-components=1; \
  rm redis.tar.gz;

WORKDIR /tmp/redis
RUN make; \
  make install; \
  cp -f src/redis-sentinel /usr/local/bin; \
  mkdir -p /etc/redis; \
  cp -f redis.conf /etc/redis; \
  rm -rf /tmp/redis

COPY conf/redis.conf /etc/redis/redis.conf
COPY conf/sysctl.conf /etc/sysctl.d/sysctl.conf

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

HEALTHCHECK --interval=30s --timeout=5s \
  CMD redis-cli ping || exit 1

EXPOSE 6379
CMD ["redis-server"]
