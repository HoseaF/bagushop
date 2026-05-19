#!/bin/bash
set -e

cd /var/www/html

mkdir -p \
    storage/app/public \
    storage/framework/cache/data \
    storage/framework/sessions \
    storage/framework/views \
    storage/logs \
    bootstrap/cache \
    public/cache

touch storage/installed

rm -rf public/storage
ln -s /var/www/html/storage/app/public public/storage

chown -R www-data:www-data storage bootstrap/cache public/cache || true
chmod -R ug+rwX storage bootstrap/cache public/cache || true

php artisan optimize:clear || true

exec apache2-foreground
