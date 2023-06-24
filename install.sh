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

##INSTALANDO LIBRERIAS PHP7.4
sudo apt-get install php7.4 php7.4-mbstring php7.4-mysqli php7.4-xml -y

##INSTALANDO GIT,CURL
sudo apt-get install curl git -y 

sudo php -v


##CREA ARCHIVO PHPINFO
echo '<?php phpinfo();' >/var/www/html/info.php

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
sudo cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php
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

##REINICIANDO SERVICIOS APACHE2
sudo systemctl reload apache2
sudo systemctl status apache2
