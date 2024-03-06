FROM alpine:3.18.6

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf

COPY ./tools/setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]
