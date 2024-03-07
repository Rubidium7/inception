#checking the .env file

echo "checking envs.."

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

echo "all necessary envs set!"

if [ -f "/var/lib/mysql/.done" ]; then
	echo "database already initialized"
else
	echo "initializing the database.."
	#initializing database
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

	#creating user, database and granting privileges
	mysqld --user=mysql --bootstrap << EOF
	USE mysql;
	FLUSH PRIVILEGES;

	ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWD}';
	CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
	CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_USER_PASSWD}';
	GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';

	FLUSH PRIVILEGES;
EOF
echo "database initialization done!"
touch /var/lib/mysql/.done
fi

#starting database
exec mysqld_safe "--defaults-file=/etc/my.cnf.d/my.cnf"
