#!/bin/bash

# 環境変数のチェック
if [ -z "$MARIADB_ROOT_PASSWORD" -o -z "$WORDPRESS_DB_NAME" -o -z "$WP_ADMIN_USER" -o -z "$WP_ADMIN_PWD" ]; then
  echo "Error: Missing required environment variables."
  exit 1
fi

# データベースディレクトリの初期化
if [ ! -d "/var/lib/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# /run/mysqldディレクトリチェック
if [ ! -d "/run/mysqld" ]; then
  echo "Creating /run/mysqld directory..."
  mkdir -p /run/mysqld
else
  echo "/run/mysqld directory already exists."
fi
chown -R mysql:mysql /run/mysqld

#Mariadb初期化されたか確認
if [ -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ]; then
	echo "MySQL directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
	echo "Creating initial databases..."
# データベースとユーザーの作成
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql > /dev/null || !mysql_install_db
fi

# データベースとユーザーの作成
tfile=`mktemp`
if [ ! -f "$tfile" ]; then
    exit 1
fi

# #必須の環境変数をチェック
# if [ -z "$WP_ADMIN_USER" ]; then
# 	echo "Error: Missing required environment variables (MYSQL_ROOT_USER)."
# 	exit 1
# fi
# if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
# 	echo "Error: Missing required environment variables (MYSQL_ROOT_PASSWORD)."
# 	exit 1
# fi

# 初期化スクリプトの内容
cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;

GRANT ALL ON *.* TO '$WP_ADMIN_USER'@'%' identified by '$MARIADB_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON *.* TO '$WP_ADMIN_USER'@'localhost' identified by '$MARIADB_ROOT_PASSWORD' WITH GRANT OPTION;
SET PASSWORD FOR '$WP_ADMIN_USER'@'localhost'=PASSWORD('$MARIADB_ROOT_PASSWORD');
CREATE DATABASE IF NOT EXISTS \`$WORDPRESS_DB_NAME\`;

FLUSH PRIVILEGES;
EOF
# databaseを作る
# if [ -z "$WORDPRESS_DB_NAME" ]; then
#   echo "Error: Missing required environment variables (MYSQL_DATABASE)."
#   exit 1
# else
#   echo "CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME" >> $tfile
# fi
# # userを作る
#   if [ -z "$WP_USER" i] || [ -z "$WP_USER_PWD" ]; then
#     echo "Error: Missing required environment variables (MYSQL_USER, MYSQL_PASSWORD)."
#     exit 1
#   else
#     echo "[info] Creating user: $WP_USER with password $WP_USER_PWD"
#     echo "CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_USER_PWD';" >> $tfile
#     echo "GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WP_USER'@'%';" >> $tfile
#   fi
#   echo "FLUSH PRIVILEGES;" >> $tfile

# MariaDBサーバーの起動と初期化スクリプトの実行
echo "Starting MariaDB server..."
mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile 
rm -f $tfile

  # echo "Database '$WORDPRESS_DB_NAME' created successfully!"
# fi

# # リモート接続を許可
# sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf
# sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# MariaDBサーバーをフォアグラウンドで起動
exec mysqld --user=mysql --console


# #!/bin/bash

# # 環境変数のチェック
# if [ -z "$MARIADB_ROOT_PASSWORD" -o -z "$WORDPRESS_DB_NAME" -o -z "$WP_ADMIN_USER" -o -z "$WP_ADMIN_PWD" ]; then
#   echo "Error: Missing required environment variables."
#   exit 1
# fi

# # データベースディレクトリの初期化
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#   echo "Initializing MariaDB data directory..."
#   mysql_install_db --user=mysql --datadir=/var/lib/mysql
# fi

# # /run/mysqldディレクトリチェック
# if [ ! -d "/run/mysqld" ]; then
#   echo "Creating /run/mysqld directory..."
#   mkdir -p /run/mysqld
#   chown -R mysql:mysql /run/mysqld
# else
#   echo "/run/mysqld directory already exists."
#   chown -R mysql:mysql /run/mysqld
# fi

# # データベースの初期化
# if [ ! -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ]; then
#   echo "Creating initial databases..."
#   chown -R mysql:mysql /var/lib/mysql

#   tfile=`mktemp`
#   if [ ! -f "$tfile" ]; then
#       exit 1
#   fi

#   # 初期化スクリプトの内容
#   cat << EOF > $tfile
# USE mysql;
# FLUSH PRIVILEGES;

# GRANT ALL ON *.* TO 'root'@'%' identified by '$MARIADB_ROOT_PASSWORD' WITH GRANT OPTION;
# GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MARIADB_ROOT_PASSWORD' WITH GRANT OPTION;
# SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MARIADB_ROOT_PASSWORD');
# DROP DATABASE IF EXISTS test;

# CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
# CREATE USER IF NOT EXISTS '$WP_ADMIN_USER'@'%' IDENTIFIED BY '$WP_ADMIN_PWD';
# GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WP_ADMIN_USER'@'%';
# FLUSH PRIVILEGES;
# EOF

#   # 初期化スクリプトの実行
#   /usr/sbin/mysqld --user=mysql --bootstrap --verbose=0 < $tfile
#   rm -f $tfile
# fi

# # MariaDBサーバーをフォアグラウンドで起動
# exec /usr/sbin/mysqld --user=mysql --console
