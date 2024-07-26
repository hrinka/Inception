# #!/bin/bash



# service mysql start 


# echo "CREATE DATABASE IF NOT EXISTS $db1_name ;" > db1.sql
# echo "CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;" >> db1.sql
# echo "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;" >> db1.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
# echo "FLUSH PRIVILEGES;" >> db1.sql

# mysql < db1.sql

# kill $(cat /var/run/mysqld/mysqld.pid)

# mysqld

!/bin/bash

# 環境変数の設定
db1_name=${MARIADB_DATABASE}
db1_user=${MARIADB_USER}
db1_pwd=${MARIADB_PASSWORD}
root_pwd=${MARIADB_ROOT_PASSWORD}

# 必要なディレクトリの作成
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

# データベースの初期化
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        exit 1
    fi

    # 初期化スクリプトの内容
    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_pwd';

CREATE DATABASE $db1_name CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$db1_user'@'%' IDENTIFIED by '$db1_pwd';
GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%';

FLUSH PRIVILEGES;
EOF

    # 初期化スクリプトの実行
    /usr/sbin/mysqld --user=mysql --bootstrap < $tfile
    rm -f $tfile
fi

# リモート接続を許可
sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# MariaDB をフォアグラウンドで起動
exec /usr/sbin/mysqld --user=mysql --console
