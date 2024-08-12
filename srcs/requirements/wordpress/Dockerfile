FROM debian:bullseye

# 必要なパッケージのインストール
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    lsb-release \
    ca-certificates \
    gnupg \
    wget \
    unzip \
    curl \
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

# RUN mkdir -p /var/www/html/wordpress
# WORKDIR /var/www/html/wordpress
# RUN wget https://wordpress.org/wordpress-latest.zip && \
#     unzip wordpress-latest.zip && \
#     rm wordpress-latest.zip && \
#     chown -R www-data:www-data /var/www/html/wordpress && \
#     chmod -R 755 /var/www/html/

# 必要な設定ファイルのコピー
COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chown www-data:www-data /var/www/html/conf/wp-config.php && chmod 644 /var/www/html/conf/wp-config.php
RUN chmod +x /usr/local/bin/entrypoint.sh

# # PHP-FPMのソケット設定を変更
RUN mkdir -p /run/php \
    && sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf

# # Entrypointの設定
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
# CMD ["bash"]


# FROM debian:bullseye

# # # 必要なパッケージのインストール
# RUN apt-get update && apt-get upgrade -y && apt-get install -y \
#     lsb-release \
#     ca-certificates \
# #     apt-transport-https \
# #     software-properties-common \
#     gnupg \
#     wget \
#     unzip \
#     curl \
# #     gettext-base \
# #     mlocate \
# #     procps \
#     && rm -rf /var/lib/apt/lists/*

# #Suryリポジトリの追加
# RUN mkdir -p /etc/apt/keyrings \
#     && echo "deb [signed-by=/etc/apt/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
#     && curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/keyrings/sury-php.gpg

# # # WP-CLIのインストール
# RUN set -ex; \
#     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
#     chmod +x wp-cli.phar; \
#     mv wp-cli.phar /usr/local/bin/wp

# # PHPと関連パッケージのインストール
# RUN apt-get update && apt-get install -y \
#     php8.2-fpm \
#     php8.2-mysql \
#     php8.2-curl \
#     php8.2-gd \
#     php8.2-intl \
#     php8.2-mbstring \
#     php8.2-xml \
#     php8.2-zip \
#     php8.2-cli \
#     php8.2-pdo \
#     && rm -rf /var/lib/apt/lists/*

# # # WordPressのインストールと設定
# RUN mkdir -p /var/www/html \
#     && cd /var/www/html \
#     && wget https://wordpress.org/latest.tar.gz \
#     && tar -xzvf latest.tar.gz \
#     && rm latest.tar.gz \
#     && chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html\
#     && find /var/www/html -type d -exec chmod 755 {} \; \
#     && find /var/www/html -type f -exec chmod 644 {} \;

# # 必要な設定ファイルのコピー
# COPY ./conf/wp-config.php /var/www/html/conf/wp-config.php
# # COPY ./conf/www.conf /etc/php/8.3/fpm/pool.d/www.conf
# COPY ./tools/entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# # PHP-FPMのソケット設定を変更
# RUN mkdir -p /run/php \
#     && sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf

# # Entrypointの設定
# CMD ["/entrypoint.sh"]
# # CMD ["bash"]

# # FROM debian:bullseye
# # RUN apt update
# # RUN apt upgrade
# # RUN apt install -y php7.4-fpm
# # # php8.2-mysqli php8.2-gd php8.2-curl php8.2-xml php8.2-mbstring php8.2-zip
# # RUN apt install -y vim wget unzip sendmail mariadb-client
# # RUN ser -eux; \
# #     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
# #     chmod +x wp-cli.phar; \
# #     mv wp-cli.phar /usr/local/bin/wp; \
# #     wp --allow-root --version
# # # COPY ./conf/www.conf etc/php/8.2/fpm/pool.d/
# # # COPY ./tools/init.sh docker-entrypoint-initdb.d/
# # # RUN chmod +x /docker-entrypoint-initdb.d/init.sh
# # # ENTRYPOINT ["./docker-entrypoint-initdb.d/init.sh"]
# # CMD ["bash"]
# # # CMD ["/usr/sbin/php-fpm7.4", "--nodaemonize", "--fpm-config", "/etc/php/7.4/fpm/php-fpm.conf"]