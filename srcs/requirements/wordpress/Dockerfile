FROM alpine:3.18.6

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

RUN addgroup -S www && \
	adduser -S -H -g "" -G www www

EXPOSE 9000

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

CMD ["sh", "/tmp/setup.sh"]
