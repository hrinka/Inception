# nginx/Dockerfile
FROM debian:bullseye

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    nginx \
    openssl 

# Nginx 設定ファイルをコピー
COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl /etc/nginx/ssl
COPY html /usr/share/nginx/html
# COPY ./default.conf /etc/nginx/conf.d/default.conf

# Nginx の実行に必要なディレクトリを作成
RUN mkdir -p /run/nginx

# Nginx をフォアグラウンドで起動
CMD ["nginx", "-g", "daemon off;"]
