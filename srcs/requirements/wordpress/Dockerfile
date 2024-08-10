FROM debian:bullseye-slim

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    gnupg \
    wget \
    unzip \
    curl \
    gettext-base \
    mlocate \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Suryリポジトリの追加
RUN mkdir -p /etc/apt/keyrings \
    && echo "deb [signed-by=/etc/apt/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
    && curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/keyrings/sury-php.gpg

# WP-CLIのインストール
RUN set -ex; \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar; \
    mv wp-cli.phar /usr/local/bin/wp

# PHPと関連パッケージのインストール
RUN apt-get update && apt-get install -y \
    php8.3-fpm \
    php8.3-mysql \
    php8.3-curl \
    php8.3-gd \
    php8.3-intl \
    php8.3-mbstring \
    php8.3-xml \
    php8.3-zip \
    php8.3-cli \
    php8.3-pdo \
    && rm -rf /var/lib/apt/lists/*

# WordPressのインストールと設定
RUN mkdir -p /var/www/html \
    && cd /var/www/html \
    && wget https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html/wordpress \
    && find /var/www/html/wordpress -type d -exec chmod 755 {} \; \
    && find /var/www/html/wordpress -type f -exec chmod 644 {} \;

# 必要な設定ファイルのコピー
COPY wp-config.php /var/www/html/wordpress/wp-config.php
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# PHP-FPMのソケット設定を変更
RUN mkdir -p /run/php \
    && sed -i 's/listen = \/run\/php\/php8.3-fpm.sock/listen = 9000/' /etc/php/8.3/fpm/pool.d/www.conf

# Entrypointの設定
CMD ["/entrypoint.sh"]
