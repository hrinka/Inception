# nginx/Dockerfile
FROM debian:bullseye

# 必要なパッケージのインストール
RUN apt-get update \
    && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Nginx 設定ファイルをコピー
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ssl /etc/nginx/ssl
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
