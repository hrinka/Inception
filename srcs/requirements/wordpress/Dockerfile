# # wordpress/Dockerfile
# FROM debian:bullseye

# # 必要なパッケージのインストール
# RUN apt-get update && apt-get install -y \
# 	wget \
# 	php8.3 \
# 	php8.3-cgi \
# 	php8.3-fpm \
# 	php8.3-mysql \
# 	php8.3-mbstring \
# 	php8.3-cli \
# 	php8.3-gd \
# 	php8.3-pdo \
# 	&& rm -rf /var/lib/apt/lists/*

# # WordPress のインストール
# RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz

# # 必要な設定ファイルのコピー
# COPY wp-config.php /var/www/html/
# # COPY wp-config.php /wordpress/
# # COPY php-fpm.conf /etc/php/fpm/php-fpm.conf

# # php-FPM の実行に必要なディレクトリを作成
# RUN mkdir /run/php

# # WordPress フォルダをデフォルトの作業ディレクトリに設定
# WORKDIR /var/www/wordpress

# # php-FPM をフォアグラウンドで起動
# CMD ["php-fpm", "-F"]

# wordpress/Dockerfile
FROM debian:bullseye

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    wget \
    php \
    php-cgi \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-cli \
    php-gd \
    php-pdo \
    && rm -rf /var/lib/apt/lists/*

# WordPress のインストール
RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz

# 必要な設定ファイルのコピー
COPY wp-config.php /wordpress/
COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

# PHP-FPM の実行に必要なディレクトリを作成
RUN mkdir /run/php

# WordPress フォルダをデフォルトの作業ディレクトリに設定
WORKDIR /var/www/wordpress

# PHP-FPM をフォアグラウンドで起動
CMD ["php-fpm7.4", "-F"]
