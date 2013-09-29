#!/usr/bin/env bash
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


options=("Apps" "WebDev" "CRWX" "CSTD" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Apps")
			echo_green "---------------------------------------"
			echo_green "Apps"
			echo_green "---------------------------------------"

			# Set up Jetpack
			APPS=( aptitude curl )

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
			APPS=( curl python-software-properties python g++ nodejs tasksel mongodb-10gen git mercurial subversion )
			NPMPGKS="yo grunt-cli bower less"
			MYWORKSPACE="web"

			if [[ -d "${HOME}/${MYWORKSPACE}" ]]; then
				cd "${HOME}/${MYWORKSPACE}/"
				else
				mkdir "${HOME}/${MYWORKSPACE}"
				cd "${HOME}/${MYWORKSPACE}/"					
			fi			

			echo_orange "Adding new sources"
			echo_orange "*********************"
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

			echo_cyan "# Installing phpmyadmin, adminer"
			fly sudo apt-get install phpmyadmin adminer -y

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
			echo ~/.bash_proflle >> "export WORKSPACE=${HOME}/${MYWORKSPACE}"

			sudo chown -R $USER:$USER /var/www
			sudo a2enmod rewrite

			echo "ServerName localhost" | sudo tee /etc/apache2/conf.d/fqdn

			echo_green "========================"
			echo_green "# Completed successfully"
			echo_green "========================"
            ;;
		"CRWX")
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
		"CSTD")
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
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
