FROM debian:bullseye

# # 必要なパッケージのインストール
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    lsb-release \
    ca-certificates \
    gnupg \
    wget \
    unzip \
    curl \
    sendmail \ 
    && rm -rf /var/lib/apt/lists/*

#Suryリポジトリの追加
RUN mkdir -p /etc/apt/keyrings \
    && echo "deb [signed-by=/etc/apt/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
    && curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/keyrings/sury-php.gpg

# # WP-CLIのインストール
RUN set -ex; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp

# PHPと関連パッケージのインストール
RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-curl \
    php8.2-gd \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    php8.2-cli \
    php8.2-pdo \
    && rm -rf /var/lib/apt/lists/*

# # # # # WordPressのインストールと設定
# RUN mkdir -p /var/www/html \
#     && cd /var/www/html \
#     && curl -O https://wordpress.org/latest.tar.gz \
#     && tar -xzf latest.tar.gz \
#     && rm latest.tar.gz

# 必要な設定ファイルのコピー
COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./tools/entrypoint.sh /var/www/html/entrypoint.sh
RUN chmod +x /var/www/html/wp-config.php
RUN chmod +x /var/www/html/entrypoint.sh

# PHP-FPMのソケット設定を変更
RUN mkdir -p /run/php \
    && sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf

# Entrypointの設定
CMD ["/var/www/html/entrypoint.sh"]
# CMD ["bash"]