FROM diegomarangoni/php:cli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /data/hello-world

WORKDIR /data/hello-world

RUN chmod -R 777 app/cache app/logs

RUN composer install --no-interaction --optimize-autoloader
RUN php app/console assets:install --env=prod --no-debug
RUN php app/console assetic:dump --env=prod --no-debug

VOLUME /var/www/hello-world

COPY bin/docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
