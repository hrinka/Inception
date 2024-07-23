#!/bin/sh

# ディレクトリの作成と所有者の設定
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

# データベースの初期化
if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql

	# データベースの初期化
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	# 一時ファイルの作成
	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	# 初期設定SQLを一時ファイルに書き込む
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PWD}';

CREATE DATABASE ${WP_DATABASE_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${WP_DATABASE_USR}'@'%' IDENTIFIED by '${WP_DATABASE_PWD}';
GRANT ALL PRIVILEGES ON ${WP_DATABASE_NAME}.* TO '${WP_DATABASE_USR}'@'%';

FLUSH PRIVILEGES;
EOF

	# 初期設定SQLを実行
	/usr/bin/mysqld --user=mysql --bootstrap < $tfile
	rm -f $tfile
fi

# リモート接続を許可する設定の変更
sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/my.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/my.cnf

# MariaDBをフォアグラウンドで起動
exec /usr/bin/mysqld --user=mysql --console
