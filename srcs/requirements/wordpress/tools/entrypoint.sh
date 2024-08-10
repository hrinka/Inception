#!/bin/bash

set -x

sed -i "s/WORDPRESS_DB_NAME/$WORDPRESS_DB_NAME/g" /var/www/html/wordpress/conf/wp-config.php
sed -i "s/WORDPRESS_DB_USER/$WORDPRESS_DB_USER/g" /var/www/html/wordpress/conf/wp-config.php
sed -i "s/WORDPRESS_DB_PASSWORD/$WORDPRESS_DB_PASSWORD/g" /var/www/html/wordpress/conf/wp-config.php
sed -i "s/WORDPRESS_DB_HOST/$WORDPRESS_DB_HOST/g" /var/www/html/wordpress/conf/wp-config.php

cd /var/www/html/wordpress
wp option update home "https://${DOMAIN_NAME}" --allow-root
wp option update siteurl "https://${DOMAIN_NAME}" --allow-root
if ! $(wp core is-installed --allow-root); then
  wp core install --url=${DOMAIN_NAME} --title=${WORDPRESS_TITLE} --admin_user=${WORDPRESS_DB_USER} --admin_password=${WORDPRESS_DB_PASSWORD} --admin_email=${WORDPRESS_EMAIL} --allow-root
  wp user create ${WORDPRESS_SECOND_USER} ${WORDPRESS_SECOND_USER_EMAIL} --role=author --user_pass=${WORDPRESS_SECOND_USER_PASSWORD} --allow-root
fi

exec /usr/sbin/php-fpm8.3 -F