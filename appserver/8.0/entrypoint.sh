#!/bin/sh

#Start php-fpm
/usr/local/sbin/php-fpm -D

# Start nginx
nginx -c /etc/nginx/nginx.conf  -g 'daemon off;'
