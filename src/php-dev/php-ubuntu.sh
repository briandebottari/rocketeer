#!/usr/bin/env bash
# script for php lang

function lamp() {
    sudo apt-get install -y tasksel
    sudo tasksel install lamp-server
    sudo apt-get install -y php5-mcrypt
    echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf && sudo a2enconf fqdn
    sudo a2enmod rewrite php5 unique_id ssl vhost_alias
    sudo php5enmod mcrypt
    sudo service apache2 restart
}

function phpmyadmin() {
    sudo apt-get install -y phpmyadmin
    echo "Include /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf
    sudo service apache2 restart
}

function phpize() {
    sudo apt-get install -y php5-dev php-pear
}

function phpmongo() {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 -y
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org php5-mongo
    sudo service mongod start
}