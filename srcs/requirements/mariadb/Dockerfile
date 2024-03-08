FROM alpine:3.18.6

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld && \
	chown -R mysql:mysql /var/log/mysql

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

EXPOSE 3306

CMD ["sh", "/tmp/setup.sh"]
