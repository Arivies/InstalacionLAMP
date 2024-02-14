#!/bin/bash


echo "ACTUALIZANDO SISTEMA!! "
sudo apt update -y && apt upgrade -y


##INSTALANDO APACHE
echo  "Instalando Apache!!"
sudo apt install apache2 -y


echo "CAMBIANDO USUARIO A DIRECTORIO WIIIII"
##CAMBIANDO USUARIO A DIRECTORIO DE SERVIDOR
sudo chown www-data:www-data -R /var/www/html

##CAMBIAR PERMISOS A DIRECTORIO  DEL SERVIDOR
echo "CAMBIANDO PERMISOS A LA CARPETA WIIIII"
sudo chmod 775 -R /var/www/html

echo "Instalando PHP!!"

sudo apt -y install lsb-release apt-transport-https ca-certificates 
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg

echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list

sudo apt update -y

##INSTALANDO LIBRERIAS PHP-8.2
#sudo apt-get install php8.2 php8.2-mbstring php8.2-mysqli php8.2-xml php8.2-curl php8.2-cli -y

sudo apt install php8.2 php8.2-bcmath php8.2-fpm php8.2-mysql php8.2-xml php8.2-zip php8.2-intl php8.2-gd php8.2-cli php8.2-bz2 php8.2-curl php8.2-mbstring php8.2-pgsql php8.2-opcache php8.2-soap php8.2-cgi -y

##INSTALACION LIBRERIA libapache2
sudo apt install libapache2-mod-php libapache2-mod-php8.2 -y

##INSTALANDO GIT,CURL
sudo apt-get install curl git -y 

sudo php -v


##CREA ARCHIVO PHPINFO
echo '<?php phpinfo(); ?>' | sudo tee /var/www/html/info.php

##INSTALACION MARIADB
echo "INSTALACION MARIA DB"
sudo apt install mariadb-server mariadb-client -y
sudo mysql_secure_installation

#GRANT ALL ON example_database.* TO 'root'@'localhost' IDENTIFIED BY 'fipaterm' WITH GRANT OPTION;
#FLUSH PRIVILEGES;

##DESCARGANDO PHPMYADMIN
echo "Instalando phpMyAdmin!!"
wget  https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz

wget  https://files.phpmyadmin.net/phpmyadmin.keyring
gpg --import phpmyadmin.keyring

wget  https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz.asc
gpg --verify phpMyAdmin-latest-all-languages.tar.gz.asc

sudo mkdir /var/www/html/phpMyAdmin

sudo tar xvf phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpMyAdmin
sudo cp /var/www/html/phpMyAdmin/config.sample.inc.php /var/www/html/phpMyAdmin/config.inc.php
sudo systemctl restart apache2


##INSTALANDO COMPOSER
echo "Instalando Composer!!"
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer

echo "Instalando NodeJS!!"
##INSTALACION NODEJS
sudo apt install nodejs npm -y

##VERSION NODEJS
node -v 

echo "Reiniciando Servicios!!"

##HABILITA  LA VERSION DE PHP QUE USARA APACHE
sudo a2enmod php8.2

##REINICIANDO SERVICIOS APACHE2
sudo systemctl reload apache2
sudo systemctl status apache2
