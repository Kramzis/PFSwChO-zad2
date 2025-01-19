FROM php:apache

# Instalowanie niezbędnych rozszerzeń oraz narzędzi
RUN apt-get update \
    && apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libonig-dev \
        libzip-dev \
        unzip \
        mariadb-client \
        git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        zip \
    && docker-php-source delete \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Uruchomienie Apache mod_rewrite
RUN a2enmod rewrite

# Ustawienie katalogu roboczego
WORKDIR /var/www/html

# Kopiowanie plików aplikacji
COPY ./src /var/www/html

# Ustalenie uprawnień
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Wystawienie portu 80
EXPOSE 80

# Start serwera Apache
CMD ["apache2-foreground"]
