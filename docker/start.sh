#!/bin/sh
set -e

cd /var/www/html

echo "Clearing caches..."

php artisan optimize:clear || true

echo "Creating storage link..."

php artisan storage:link || true

if [ "$RUN_MIGRATIONS" = "true" ]; then
    echo "Running migrations..."
    php artisan migrate --force || true
fi

echo "Ensuring Bagisto installed lock exists..."

touch storage/installed

echo "Starting Apache..."

exec apache2-foreground
