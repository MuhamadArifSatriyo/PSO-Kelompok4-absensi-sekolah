FROM php:8.1-apache

# Install PHP extensions dan dependencies tambahan untuk menjalankan spark
RUN apt-get update && apt-get install -y \
    unzip \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli zip mbstring xml \
    && a2enmod rewrite

# Copy source code ke direktori Apache
COPY . /var/www/html/

# Set working directory ke folder project CodeIgniter
WORKDIR /var/www/html/

# Set permission agar www-data bisa akses folder
RUN chown -R www-data:www-data /var/www/html

# Install Composer (jika perlu, untuk dependency PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Expose port 8080 (default php spark serve)
EXPOSE 8080
