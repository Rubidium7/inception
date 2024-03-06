#checking the .env file

if [ -z "$DOMAIN_NAME" ]; then
	echo "Error: DOMAIN_NAME env is not set"
	exit 1
fi

if [ -z "$WP_TITLE" ] || [ -z "$WP_ADMIN" ] || [ -z "$WP_ADMIN_EMAIL" ] ||
	[ -z "$WP_ADMIN_PASSWD" ] || [ -z "$WP_USER" ] || [ -z "$WP_USER_EMAIL" ] ||
	[ -z "$WP_USER_PASSWD" ] ; then
	echo "Error: all wordpress envs not set"
	exit 1
fi

if [ -z "$DB_NAME" ] || [ -z "$DB_ROOT_PASSWD" ] ||
	[ -z "$DB_USER" ] || [ -z "$DB_USER_PASSWD" ]; then
	echo "Error: all mariadb envs are not set"
	exit 1
fi

#creating necessary directories
mkdir -p /var/lib/mysql /run/mysqld  /var/log/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
touch /var/log/mysql/error.err

#initializing database
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

#creating user, database and granting privileges
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWD';
CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';

FLUSH PRIVILEGES;
EOF

#starting database
exec mysqld_safe --defaults-file=/etc/my.cnf.d/my.cnf
