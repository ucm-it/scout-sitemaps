FROM php:8.3-cli-alpine

RUN apk add --no-cache \
    git \
    unzip \
    curl \
    libzip-dev \
    chromium \
    && docker-php-ext-install zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN git clone --branch v3.0.0 --depth 1 \
    https://github.com/iprodev/PHP-XML-Sitemap-Generator.git \
    /app/sitemap-generator \
    && composer install --no-dev -d /app/sitemap-generator

WORKDIR /output

ENTRYPOINT ["php", "-d", "memory_limit=-1", "/app/sitemap-generator/bin/sitemap"]
