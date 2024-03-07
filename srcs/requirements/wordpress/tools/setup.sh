
MAX_RETRIES=7

RETRY_INTERVAL=5

attempts=0

while [ $attemps -lt $MAX_RETRIES ]; do
	if wget --spider -q mariadb:3306; then
		echo "mariadb ready for wordpress"
		break
	else
		echo "wordpress waiting for mariadb to start up.."
		sleep $RETRY_INTERVAL
	fi
	attempts=$((attempts + 1))
done

if [ $attemps -eq $MAX_RETRIES ]; then
	echo "mariadb took too long, wordpress setup.sh exiting.."
	exit 1
fi

if [ -f "/var/www/html/.done" ]; then
	echo "wordpress already set up" 
else
	echo "starting wordpress setup"	
	wp config create \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_USER_PASSWD \
		--dbhost=mariadb \
		--force

	echo "wordpress config set"	

	wp core install \
		--url=$DOMAIN_NAME \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASSWD \
		--admin_email=$WP_ADMIN_EMAIL \
		--path=/var/www/html \
		--skip-email \
		--allow-root
	
	echo "wordpress core installed"

	wp user create \
		$WP_USER $WP_USER_EMAIL \
		--role=editor \
		--user_pass=$WP_USER_PASSWD \
		--path=/var/www/html/

	echo "wordpress user created"

	wp theme install kubio \
		--activate \
		--allow-root

	wp plugin update --all
	wp option update siteurl "https://$DOMAIN_NAME"
	wp option update home "https://$DOMAIN_NAME"
	touch /var/www/html/.done
	echo "wordpress setup done!"
fi

chown -R www:www /var/www/html
chmod -R 775 /var/www/html

exec /usr/sbin/php-fmp81 -F
