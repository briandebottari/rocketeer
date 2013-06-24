#!/usr/bin/env
# Inspired from thoughtbot/laptop
CLEAR="\033[0m"
ORANGE="\033[33m"
GREEN="\033[32m"
CYAN="\033[36m"
RED="\033[31m"

echo_orange() {
  echo -e ${ORANGE}$1${CLEAR}
}

echo_green() {
	echo -e ${GREEN}$1${CLEAR}
}

echo_cyan() {
	echo -e ${CYAN}$1${CLEAR}
}

echo_red() {
	echo -n ${RED}$1${CLEAR}
}

fly() {
  $* || (echo_red "Failed" 1>&2 && exit 1)
}

rocketeer() {
cat  <<"EOT"
                   ______      _____                  
______________________  /________  /__________________
__  ___/  __ \  ___/_  //_/  _ \  __/  _ \  _ \_  ___/
_  /   / /_/ / /__ _  ,<  /  __/ /_ /  __/  __/  /    
/_/    \____/\___/ /_/|_| \___/\__/ \___/\___//_/      
EOT
}


echo -e "\033[32m $(rocketeer)"
echo -e "\033[34m Rocketeer : piqus/rocketeer"
echo -e "\033[35m for Ubuntu 13.04"
echo -e "\033[32m ****************************************************"
echo -e "\033[0m"

selection=$(zenity --list "Chmod RWX", "Chmod Std", "Vhost", "Apps" "WebDev" "Theme", "AptGet Update List"  --column="" --text="Action" --title="Rocketeer")
case "$selection" in
"Apps")
	echo_green "---------------------------------------"
	echo_green "Apps"
	echo_green "---------------------------------------"

	# Set up Jetpack
	APPS=( aptitude agave chromium-browser curl gimp gnome-tweak-tool inkscape keepass2 shutter sublime-text synaptic unity-tweak-tool )

	echo_orange "Adding new sources"
	echo_orange "*********************"
	sudo add-apt-repository ppa:webupd8team/sublime-text-2

	echo_orange "Updating source lists"
	echo_orange "*********************"
	sudo apt-get update

	# Let's fly
	echo_orange "Installing application"
	echo_orange "*********************"
	for APP in ${APPS[@]}
	do
		echo_cyan "# Installing $APP"
		fly sudo apt-get install $APP -y
	done

	echo_green "========================"
	echo_green "# Completed successfully"
	echo_green "========================"
	;;
"WebDev")
	echo_green "---------------------------------------"
	echo_green "WebDev"
	echo_green "---------------------------------------"

	# Set up Jetpack
	APPS=( curl python-software-properties python g++ make sublime-text nodejs tasksel mongodb-10gen git mercurial subversion rapidsvn pidgin)
	NPMPGKS="yo grunt-cli bower less express"
	MYWORKSPACE="web"
	cd "${HOME}/${MYWORKSPACE}/"

	echo_orange "Adding new sources"
	echo_orange "*********************"
	sudo add-apt-repository ppa:webupd8team/sublime-text-2
	sudo add-apt-repository ppa:chris-lea/node.js
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list

	echo_orange "Updating source lists"
	echo_orange "*********************"
	sudo apt-get update

	echo_orange "Installing application"
	echo_orange "*********************"
	for APP in ${APPS[@]}
	do
		echo_cyan "# Installing $APP"
		fly sudo apt-get install $APP -y
	done

	echo_cyan "# Installing lamp-server"
	fly sudo tasksel install lamp-server

	echo_cyan "# Installing phpmyadmin, adminer, mysql-workbench"
	fly sudo apt-get install phpmyadmin adminer mysql-workbench -y

	echo_cyan "# Installing php5-dev, php-pear"
	fly sudo apt-get install php5-dev php-pear php5-mongo -y

	echo_cyan "# Installing npm packages globally"
	sudo npm install -g $NPMPGKS

	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer

	# echo_cyan "# Installing redis"
	# wget http://download.redis.io/redis-stable.tar.gz
	# tar xvzf redis-stable.tar.gz
	# cd redis-stable
	# make
	# sudo cp redis-server /usr/local/bin/
	# sudo cp redis-cli /usr/local/bin/
	# cd ..
	
	mkdir "${HOME}/${MYWORKSPACE}"

	# echo ~/.bash_proflle >> "export WORKSPACE=${HOME}/$MYWORKSPACE"

	sudo chown -R $USER:$USER /var/www
	sudo a2enmod rewrite

	echo "ServerName localhost" | sudo tee /etc/apache2/conf.d/fqdn

	echo_green "========================"
	echo_green "# Completed successfully"
	echo_green "========================"
	;;
"Theme")
	echo_green "---------------------------------------"
	echo_green "Look'ma new jetpack"
	echo_green "---------------------------------------"

	# Set up Jetpack
	echo_orange "Adding new sources"
	echo_orange "*********************"
	sudo add-apt-repository ppa:tiheum/equinox

	echo_orange "Updating source lists"
	echo_orange "*********************"
	sudo apt-get update

	# Let's fly
	echo_orange "Installing application"
	echo_orange "*********************"				
	echo_cyan "# Installing faience-theme"
	fly sudo apt-get install faience-theme faience-icon-theme -y


	echo_green "========================"
	echo_green "# Completed successfully"
	echo_green "========================"
	zenity --info --text="Not finished yet"
	;;
"AptGet Update List")
	echo_orange 'Update Packages List'
	echo_orange "*********************"	
	fly sudo apt-get update

	echo_green "========================"
	echo_green "# Completed successfully"
	echo_green "========================"
	;;
"Chmod RWX")
	echo_orange 'Choose location (mod)'
	echo_orange "*********************"	
	read LOCATION
	fly sudo find $LOCATION -type f -exec chmod 666 {} \;
	fly sudo find $LOCATION -type d -exec chmod 777 {} \;
	fly sudo chown user:group -R $LOCATION

	echo_green "========================"
	echo_green "# Completed successfully"
	echo_green "========================"
	;;
"Chmod Std")
	echo_orange 'Choose location (std)'
	echo_orange "*********************"	
	read LOCATION
	fly sudo find $LOCATION -type f -exec chmod 644 {} \;
	fly sudo find $LOCATION -type d -exec chmod 755 {} \;
	fly sudo chown user:group -R $LOCATION

	echo_green "========================"
	echo_green "# Completed successfully"
	echo_green "========================"
	;;
"Vhost")
	echo_green "---------------------------------------"
	echo_green "vhost generator"
	echo_green "---------------------------------------"
	echo_cyan "Web location (i.e. wwwmylaravel.com)"
	read TMP_HOST
	echo_cyan "Alias (i.e. www.wwwmylaravel.com)"
	read TMP_ALIAS
	echo_cyan "Local folder location (i.e. /home/me/web/my-laravel/)"
	read TMP_LOCATION

	cat <<Endofmessage
<VirtualHost *:80>
    ServerName $TMP_HOST
    ServerAlias $TMP_ALIAS
    
    DocumentRoot "$TMP_LOCATION"
    <Directory "$TMP_LOCATION">
       	Options Indexes FollowSymLinks MultiViews
        AllowOverride all
        allow from all
    </Directory>

    ErrorLog "${APACHE_LOG_DIR}/${TMP_HOST}-error.log"
    CustomLog "${APACHE_LOG_DIR}/${TMP_HOST}-access.log" common
</VirtualHost>
Endofmessage
	echo_orange "Copy it to file!!"

	echo_green "========================"
	echo_green "# Completed successfully"
	echo_green "========================"
	;;		
esac
