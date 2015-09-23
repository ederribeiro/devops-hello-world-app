#!/bin/bash

echo "Hello World!"

chmod -R 777 app/{cache,logs}

if [ "$1" = "--dev" ]; then
    rm -rf app/{cache,logs}/*

    composer install
    php app/console assets:install
    php app/console assetic:dump

    exec php app/console server:run 0.0.0.0:8000
fi

if [ "$1" = "--prod" ]; then
    exec php app/console server:run 0.0.0.0:8000 --env=prod --no-debug
fi

if [ -z "$@" ]; then
    cp -rf /data/hello-world/* /var/www/hello-world/

    exec true
fi

exec $@
