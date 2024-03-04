
FROM alpine:3.18

RUN << EOF 
apk update
apk add --no-cache nginx 
apk add --no-cache openssl
adduser -D -s /sbin/nologin -g www-data -G www-data www-data
mkdir -p /etc/nginx/ssl
EOF

#adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data?

RUN openssl req -x509 -sha256 -days 365 -nodes -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/certificate.key \
	-out /etc/nginx/ssl/certificate.crt \
	-subj "/C=FI/ST=Helsinki/L=Helsinki/O=42/OU=Hive/CN=nlonka.42.fr"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443
