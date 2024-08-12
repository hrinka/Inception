#!/bin/bash

# 環境変数のチェック
if [ -z "$MARIADB_ROOT_PASSWORD" -o -z "$WORDPRESS_DB_NAME" -o -z "$WORDPRESS_DB_USER" -o -z "$WORDPRESS_DB_PASSWORD" ]; then
  echo "Error: Missing required environment variables."
  exit 1
fi

# データベースディレクトリの初期化
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# MariaDBサーバーの起動
echo "Starting MariaDB server..."
mysqld --user=mysql --socket=/run/mysqld/mysqld.sock &

# MariaDBサーバーの起動待ち
until mysqladmin ping -h"localhost" --socket=/run/mysqld/mysqld.sock --silent; do
  echo "Waiting for MariaDB server to start..."
  sleep 1
done

# ルートパスワードの設定
if [ -n "$MARIADB_ROOT_PASSWORD" ]; then
  echo "Setting root password..." 
  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"
fi

# データベースとユーザーの作成
echo "Creating database and user..."
mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$WORDPRESS_DB_NAME\`;"
mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "GRANT ALL ON \`$WORDPRESS_DB_NAME\`.* TO '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"

# WordPress用のデータベースを作成
echo "Creating WordPress database..."
mysql -u root -p"$MARIADB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`wordpress\`;"

# MariaDBサーバーの停止
echo "Stopping MariaDB server..."
mysqladmin -u root -p"$MARIADB_ROOT_PASSWORD" shutdown

# MariaDBサーバーをフォアグラウンドで起動
echo "Starting MariaDB server..."
exec mysqld --user=mysql


# #!/bin/bash

# # check env variables
# if [ -z "$MARIADB_PASSWORD" -o -z "$MARIADB_DATABASE" -o -z "$MARIADB_USER" ]; then
#   echo "Error: Missing required environment variables."
#   exit 1
# fi

# # 必要なディレクトリの作成
# if [ ! -d "/run/mysqld" ]; then
#     mkdir -p /run/mysqld
#     chown -R mysql:mysql /run/mysqld
# fi

# # データベースの初期化
# echo "初期化前"

# if [ ! -d "/var/lib/mysql/$MARIADB_DATABASE" ]; then
# echo "in"
#     chown -R mysql:mysql /var/lib/mysql
#     mariadb-upgrade --user=mysql --datadir=/var/lib/mysql

#     tfile=`mktemp`
#     if [ ! -f "$tfile" ]; then
#         exit 1
#     fi

#     # 初期化スクリプトの内容
#     cat << EOF > $tfile
# USE mysql;
# FLUSH PRIVILEGES;

# DELETE FROM mysql.user WHERE User='';
# DROP DATABASE IF EXISTS test;
# DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';

# CREATE DATABASE $MARIADB_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
# CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASSWORD';
# GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%';

# FLUSH PRIVILEGES;
# EOF

#     # 初期化スクリプトの実行
#     /usr/sbin/mysqld --user=mysql --bootstrap < $tfile
#     rm -f $tfile
# fi

# # リモート接続を許可
# sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf
# sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# # MariaDB をフォアグラウンドで起動
# exec /usr/sbin/mysqld --user=mysql --console
