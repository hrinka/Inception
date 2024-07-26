#!/bin/bash

# 環境変数の設定
DOMAIN_NAME=hrinka.42.fr
CERTS_=/etc/ssl/private/nginx-selfsigned.crt

# OpenSSLを使用して自己署名証明書を生成
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out $CERTS_ -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42 School/OU=student/CN=$DOMAIN_NAME"

# NGINXの設定ファイルを生成
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name $DOMAIN_NAME www.$DOMAIN_NAME;

    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_protocols TLSv1.2 TLSv1.3;

    root /usr/share/nginx/html;
    index index.html index.htm;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_pass wordpress:9000;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

# NGINXを再起動して新しい設定を反映
nginx -g "daemon off;"
