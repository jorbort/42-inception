#!/bin/sh

echo "Waiting for database to be ready..."
while ! nc -z $DB_HOST 3306; do   
  sleep 1 # wait for 1 second before check again
done
echo "Database is ready!"

#Check if php-fpm configuration file exists (it should after installing php-fpm), we then replace line starting by "listen = " for "listen = 0.0.0.0:9000" so it will be listening to requests from port 9000. 
if [ -f /etc/php/7.4/fpm/pool.d/www.conf ]; then
	sed -i '/^listen = /s/.*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf
	echo "Successfully edited www.conf: Listening on port 9000."
else
	echo "Error: www.conf file doesn't exist"
fi

#Check if wordpress configuration file exists (this time it should not since we didn't download wordpress yet), after checking we download and install wordpress with the credentials passed with .env file
if [ ! -f ./wp-config.php ]
then
	wp core download --locale=en_US --allow-root
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --dbprefix=$DB_PREFIX --allow-root
	wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS --allow-root
	wp theme install twentysixteen --activate --allow-root
fi

#Execute php-fpm with -F flag so it won't run in detached mode, it will run in the foreground and print error and output streams in the terminal
echo "Executing php-fpm7.4 -F..."
/usr/sbin/php-fpm7.4 -F