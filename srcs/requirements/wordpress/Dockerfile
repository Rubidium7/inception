FROM alpine:3.18.6

RUN addgroup -S www && \
	adduser -S -H -g "" -G www www

RUN apk update && \
	apk add --no-cache \
	php81 \
	php81-fpm \
	php81-cgi \
	php81-phar \
	php81-mysqli \
	php81-mbstring \
	php81-json \
	php81-iconv \
	php81-zip \
	php81-curl \
	curl \
	libcurl \
	wget \
	libzip

RUN mkdir -p /var/www/html /run/php

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY ./tools/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

EXPOSE 9000

ENTRYPOINT ["/tmp/setup.sh"]
