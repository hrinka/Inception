FROM debian:bullseye

# 必要なパッケージのインストール
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# MariaDB 設定ファイルをコピー
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# 初期化スクリプトをコピー
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 初期化スクリプトを実行し、MariaDBを起動
ENTRYPOINT ["sh", "/entrypoint.sh"]
# CMD ["bash"]