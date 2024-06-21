#!/bin/sh

if [ -f /var/www/html/wordpress/index.php ]; then
    echo "WordPress already downloaded"
else
    rm -rf /var/www/html/wp-admin/* /var/www/html/wp-content/* /var/www/html/wp-includes/*
    # Download WordPress and all config files
    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    mv wordpress/* /var/www/html/
    rm -rf latest.tar.gz wordpress

    # Use WP-CLI to set up WordPress
    wp core download --path=/var/www/html/wordpress --allow-root
    wp config create --path=/var/www/html/wordpress --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --allow-root
    wp core install --path=/var/www/html/wordpress --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL --admin_password=$WP_ADMIN_PASS --skip-email --allow-root
    wp user create --path=/var/www/html/wordpress $WP_USER $WP_EMAIL --user_pass=$WP_PASS --allow-root
fi

exec "$@"