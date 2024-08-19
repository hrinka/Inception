#!/bin/bash

set -x

# 必要な権限の設定
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# WordPressのインストール
if ! $(wp core is-installed --allow-root --path='/var/www/html') ; then
  wp core download --path='/var/www/html' --allow-root
  wp core config --path='/var/www/html' --dbname=$MARIADB_NAME --dbuser=$WP_USER --dbpass=$WP_USER_PWD --dbhost=$MARIADB_HOST --allow-root
  wp core install --path='/var/www/html' --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root
  wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --path='/var/www/html' --allow-root
fi
exec php-fpm8.2 -F

# #!/bin/bash

# set -x

# # cd /var/www/html
# if [ -z "$WORDPRESS_DB_NAME" -o -z "$WP_ADMIN_USER" -o -z "$WP_ADMIN_PWD" -o -z "$WORDPRESS_DB_HOST" ]; then
#   echo "Error: Missing required environment variables."
#   exit 1
# fi

# # 必要な権限の設定
# chown -R www-data:www-data /var/www/html
# chmod -R 755 /var/www/html

# # wp-config.phpの存在確認と権限設定
# chown www-data:www-data /var/www/html/wp-config.php
# chmod 644 /var/www/html/wp-config.php

# # sed -i "s_DB_NAME/$WORDPRESS_DB_NAME/g" /var/www/html/wp-config.php
# # sed -i "s/WP_ADMIN_USER/$WP_ADMIN_USER/g" /var/www/html/wp-config.php
# # sed -i "s/WP_ADMIN_PWD/$WP_ADMIN_PWD/g" /var/www/html/wp-config.php
# # sed -i "s_DB_HOST/$WORDPRESS_DB_HOST/g" /var/www/html/wp-config.php

# wp core download --path=/var/www/html --allow-root
# wp core config --dbname=${WORDPRESS_DB_NAME} --dbuser=${WP_ADMIN_USER} --dbpass=${WP_ADMIN_PWD} --dbhost=${WORDPRESS_DB_HOST} --path=/var/www/html --allow-root
# wp core install --path=/var/www/html --url=${DOMAIN_NAME} --title=${WORDPRESS_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
# wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --path=/var/www/html --allow-root

# exec /usr/sbin/php-fpm8.2 -F