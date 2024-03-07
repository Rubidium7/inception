FROM alpine:3.18.6

#debug vv
ENV DOMAIN_NAME=nlonka.42.fr

ENV WP_TITLE=inception
ENV WP_ADMIN=rubidium
ENV WP_ADMIN_EMAIL=rubidium@42.fr
ENV WP_ADMIN_PASSWD=horse2
ENV WP_USER=nlonka
ENV WP_USER_EMAIL=layman@42.fr
ENV WP_USER_PASSWD=horse2

ENV DB_NAME=inception_db
ENV DB_ROOT_PASSWD=horse2
ENV DB_USER=nlonka
ENV DB_USER_PASSWD=horse2

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld && \
	chown -R mysql:mysql /var/log/mysql && \
	touch /var/log/mysql/error.err

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

EXPOSE 3306

CMD ["sh", "/tmp/setup.sh"]
