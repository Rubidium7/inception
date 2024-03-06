FROM alpine:3.18.6

RUN apk update && \
	apk add --no-cache \
	nginx \
	openssl

RUN	mkdir -p /etc/nginx/ssl /run/nginx && \
	addgroup -S www && \
	adduser -S -H -g "" -G www www

RUN openssl req -x509 -sha256 -days 365 -nodes -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/certificate.key \
	-out /etc/nginx/ssl/certificate.crt \
	-subj "/C=FI/ST=Helsinki/L=Helsinki/O=42/OU=Hive/CN=$DOMAIN_NAME"

COPY ./tools/index.html /var/www/html

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

RUN sed -i 's/user nginx/user www www/' /etc/nginx/nginx.conf && \
	sed -i 's/ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;/ssl_protocols TLSv1.2 TLSv1.3/' /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
