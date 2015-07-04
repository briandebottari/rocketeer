#!/usr/bin/env bash


function keepassx() {
    sudo apt-add-repository ppa:keepassx/daily-y
    sudo apt-get update
    sudo apt-get keepassx -y
}

function nautilus_fix() {
    sudo apt-get nautilus-open-terminal -y
}

function zshell() {
    sudo apt-get install -y zsh git
    curl -L http://install.ohmyz.sh | sh
}

function docker() {
    curl -Ss https://get.docker.io/ubuntu/ > docker.sh
    sudo bash docker.sh
}

function sshgen() {
	read -e -p "Enter Your Email:" -i "ovirendo@gmail.com" YOUR_EMAIL
	ssh-keygen -t rsa -b 4096 -C "$YOUR_EMAIL"
	eval "$(ssh-agent -s)"
}

function fishell() {
    sudo apt-add-repository ppa:fish-shell/release-2 -y
    sudo apt-get update
    sudo apt-get install fish -y
}

function ohmyzsh() {
    sudo apt-get zsh git -y
    curl -L http://install.ohmyz.sh | sh
}

function sshcopy() {
	# $1 should be id_rsa, id_github, etc. etc.
	ssh-add ~/.ssh/$1
	sudo apt-get install xclip
	xclip -sel clip < ~/.ssh/$1.pub
}

function install() {
	sudo apt-get install $#
}

function phpcomposer() {
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
}

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
    sudo apt-key adv --keyserver hkp://keyserxer.ubuntu.com:80 --recv 7F0CEB10 -y
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org php5-mongo
    sudo service mongod start
}

function devvhosts() {
    # DNSMASQ_DOMAIN="dev"
    sudo apt-get install -y dnsmasq
    echo "listen-address=127.0.0.1" | sudo tee -a /etc/dnsmasq.conf
    echo "address=/dev/127.0.0.1" | sudo tee /etc/dnsmasq.d/dev
    # echo "prepend domain-name-servers 127.0.0.1;" | sudo tee -a /etc/dhcp/dhclient.conf
    # sudo dhclient
    
    # echo "add proper vhost.conf"
}

function nodejs() {
    curl -sL https://deb.nodesource.com/setup |sudo bash -
    sudo apt-get install -y nodejs
}
