# # ベースイメージとしてDebian Bullseyeを使用
# FROM debian:bullseye

# # 必要なパッケージのインストール
# RUN apt-get update && apt-get install -y mariadb-server

# # MariaDB 設定ファイルをコピー
# # COPY my.cnf /etc/mysql/my.cnf

# # 初期設定スクリプトをコンテナにコピー
# COPY configure.sh /usr/local/bin/configure.sh

# # データディレクトリの所有者をmysqlに設定
# RUN chown -R mysql:mysql /var/lib/mysql

# # MariaDBの初期化と設定を行うスクリプトをENTRYPOINTで実行
# ENTRYPOINT ["sh", "/usr/local/bin/configure.sh"]

# # MariaDBをフォアグラウンドで起動
# CMD ["mysqld"]
# mariadb/Dockerfile
FROM debian:bullseye

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y mariadb-server

# MariaDB 設定ファイルをコピー
COPY my.cnf /etc/mysql/my.cnf

# データディレクトリの所有者をmysqlに設定
RUN chown -R mysql:mysql /var/lib/mysql

# 初期化スクリプトをコピー
COPY configure.sh /usr/local/bin/configure.sh

# 初期化スクリプトを実行し、MariaDBを起動
ENTRYPOINT ["sh", "/usr/local/bin/configure.sh"]
