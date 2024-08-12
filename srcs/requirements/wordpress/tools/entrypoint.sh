#!/bin/bash

set -x

# 必要な権限の設定
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# wp-config.phpの存在確認と権限設定
chown www-data:www-data /var/www/html/wp-config.php
chmod 644 /var/www/html/wp-config.php

sed -i "s/WORDPRESS_DB_NAME/$WORDPRESS_DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/WORDPRESS_DB_USER/$WORDPRESS_DB_USER/g" /var/www/html/wp-config.php
sed -i "s/WORDPRESS_DB_PASSWORD/$WORDPRESS_DB_PASSWORD/g" /var/www/html/wp-config.php
sed -i "s/WORDPRESS_DB_HOST/$WORDPRESS_DB_HOST/g" /var/www/html/wp-config.php

# cd /var/www/html
wp core config --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_USER} --dbpass=${WORDPRESS_DB_PASSWORD} --dbhost=${WORDPRESS_DB_HOST} --allow-root
wp core install --url=${DOMAIN_NAME} --title=${WORDPRESS_TITLE} --admin_user=${WORDPRESS_DB_USER} --admin_password=${WORDPRESS_DB_PASSWORD} --admin_email=${WORDPRESS_EMAIL} --allow-root

exec /usr/sbin/php-fpm8.2 -F

# #!/bin/bash

# set -e

# # 環境変数のチェック
# if [ -z "$WORDPRESS_DB_NAME" -o -z "$WORDPRESS_DB_USER" -o -z "$WORDPRESS_DB_PASSWORD" -o -z "$WORDPRESS_DB_HOST" ]; then
#   echo "Error: Missing required environment variables."
#   exit 1
# fi

# # 必要な権限の設定
# chown -R www-data:www-data /var/www/html
# chmod -R 755 /var/www/html/

# # wp-config.phpの設定
# if [ -f /var/www/html/wp-config.php ]; then
#   sed -i "s/WORDPRESS_DB_NAME/$WORDPRESS_DB_NAME/g" /var/www/html/wp-config.php
#   sed -i "s/WORDPRESS_DB_USER/$WORDPRESS_DB_USER/g" /var/www/html/wp-config.php
#   sed -i "s/WORDPRESS_DB_PASSWORD/$WORDPRESS_DB_PASSWORD/g" /var/www/html/wp-config.php
#   sed -i "s/WORDPRESS_DB_HOST/$WORDPRESS_DB_HOST/g" /var/www/html/wp-config.php
# else
#   echo "Error: /var/www/html/wp-config.php not found."
#   exit 1
# fi

# # WordPressのインストール
# if ! $(wp core is-installed --path=/var/www/html --allow-root); then
#   wp core config --path=/var/www/html --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root
#   wp core install --path=/var/www/html --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_DB_USER --admin_password=$WORDPRESS_DB_PASSWORD --admin_email=$WORDPRESS_EMAIL --allow-root
#   wp user create $WORDPRESS_SECOND_USER $WORDPRESS_SECOND_USER_EMAIL --role=author --user_pass=$WORDPRESS_SECOND_USER_PASSWORD --path=/var/www/html --allow-root
# fi

# # PHP-FPMの起動
# exec php-fpm8.2 -F