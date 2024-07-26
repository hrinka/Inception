FROM debian:bullseye

# 必要なパッケージのインストール
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y mariadb-server vim 
# MariaDB 設定ファイルをコピー
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# 初期化スクリプトをコピー
COPY ./tools/configure.sh /usr/local/bin/configure.sh
RUN chmod +x /usr/local/bin/configure.sh

# 初期化スクリプトを実行し、MariaDBを起動
ENTRYPOINT ["sh", "/usr/local/bin/configure.sh"]
# CMD ["bash"]