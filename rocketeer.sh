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
echo -e "\033[35m for Ubuntu 14.04"
echo -e "\033[32m ****************************************************"
echo -e "\033[34m Open rocketeer.sh and append these functions what you want execute"
echo -e "\033[0m"

CLI_APPS="aptitude tasksel curl tree git subversion mercurial fish zsh unzip unrar-free"
GUI_APPS="rapidsvn synaptic gksu agave git-cola rapidsvn mysql-workbench keepass2 keepassx thunderbird chromium-browser inkscape gimp shutter pidgin filezilla"
TASKSEL="lamp-server phpmyadmin"
PPA_APPS="sublime-text oh-my-zsh nodejs atom spotify-client keepassx"
MISC="ssh tmux vim git-core wget zip unzip mcrypt imagemagick libmagickwand-dev htop whois dnsutils powertop gparted zenmap terminator"

function install() {
    sudo apt-get install -y $1
}

function fishell() {
    sudo apt-add-repository ppa:fish-shell/release-2
    sudo apt-get update
    install fish
}

function zukitwo() {
    install gtk2-engines-murrine gtk2-engines-pixbuf
    #https://github.com/lassekongo83/zuki-themes
    wget "https://github.com/lassekongo83/zuki-themes/archive/master.zip"
    unzip "zuki-themes-master.zip"
    mv zuki-themes-master/* ~/.themes
}

function sublime() {
    curl -sS "http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb" > sublime-text_build-3059_amd64.deb
    sudo dpkg --install sublime-text_build-3059_amd64.deb 
}

function upgrade() {
    sudo apt-get update
    sudo apt-get upgrade
}

function atom() {
    sudo add-apt-repository ppa:webupd8team/atom
    sudo apt-get update
    install atom
}

function brackets() {
    curl -sS "https://github.com/adobe/brackets/releases/download/release-0.42/Brackets.Release.0.42.64-bit.deb"
}

function nodejs() {
    curl -sL https://deb.nodesource.com/setup |sudo bash -
    install nodejs
}

function spotify() {
    echo "deb http://repository.spotify.com stable non-free" > sudo tee -a /etc/apt/sources.list.d/spotify.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59
    sudo apt-get update
    install spotify-client
}

function gnome_shell_extensions() {
    echo "https://extensions.gnome.org/extension/307/dash-to-dock/"
    echo "https://extensions.gnome.org/extension/53/pomodoro/"
    echo "https://extensions.gnome.org/extension/442/drop-down-terminal/"
    echo "https://extensions.gnome.org/extension/584/taskbar/"
    echo "https://extensions.gnome.org/extension/495/topicons/"
    
    sudo add-apt-repository ppa:gnome-shell-extensions
    sudo apt-get update
    install gnome-shell-extension-weather

}

function lamp() {
    install tasksel
    sudo tasksel install lamp-server
    echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf && sudo a2enconf fqdn
    sudo a2enmod rewrite php5 unique_id ssl alias
    sudo php5enmod mcrypt
    sudo service apache2 restart
}

function phpmyadmin() {
    # require lamp
    install phpmyadmin
    echo "\nInclude /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf
    sudo service apache2 restart
}

function php_composer() {
    # require php
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
}

function phpize() {
    install php5-dev php-pear
}

function phpmongo() {
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee -a /etc/apt/sources.list.d/mongodb.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    sudo apt-get update
    install mongodb-org php5-mongo     
}

function pomodoro() {
    install gnome-common intltool valac libglib2.0-dev gobject-introspection libgirepository1.0-dev libgtk-3-dev libgnome-desktop-3-dev libcanberra-dev libdbus-glib-1-dev libgstreamer1.0-dev libupower-glib-dev fonts-droid

    version=`gnome-shell --version | cut --delimiter=' ' -f 3`
    versions="3.13\n3.12\n3.10\n3.08\n$version"
    version_check=`echo $versions | sort -n | grep "$version" -n | cut -d':' -f 1`

    link=""
    [[ $version_check = 2 ]] && link="https://codeload.github.com/codito/gnome-shell-pomodoro/legacy.tar.gz/gnome-3.12"
    [[ $version_check = 3 ]] && link="https://codeload.github.com/codito/gnome-shell-pomodoro/legacy.tar.gz/gnome-3.10"
    [[ $version_check = 4 ]] && link="https://codeload.github.com/codito/gnome-shell-pomodoro/legacy.tar.gz/gnome-3.8"

    if [[ $link -eq 1 ]]; then
        echo "Manual installation nedeed: https://github.com/codito/gnome-shell-pomodoro"
    else
        curl -sS $link > gnome-shell-pomodoro.tar.gz
        tar -xzf gnome-shell-pomodoro.tar.gz
        cd codito-gnome-shell-pomodoro-*
        ./autogen.sh --prefix=/usr --datadir=/usr/share
        make
        sudo make install
    fi

    gnome-pomodoro &
    cd ..
}

function zsh() {
    install zsh git
    curl -L http://install.ohmyz.sh | sh
}

function docker() {
    curl -Ss https://get.docker.io/ubuntu/ > docker.sh
    sudo bash docker.sh
}

function keepassx() {
    sudo apt-add-repository ppa:keepassx/daily
    sudo apt-get update
    install keepassx
}


function nautilus_fix() {
    # You can also change background color to #17191D <3
    install nautilus-open-terminal 
}

function addvars() {
    export APACHE_LOG_DIR="/var/log/apache2/"
}


## Example (just uncomment):
## @todo: add fancy interactive mode
## ----------
# upgrade
# install $CLI_APPS
# lamp
# phpmyadmin
# phpize
# fishell
# php_composer
# phpmongo


## Example (or with expliciting error):
## @todo: add better verbose mode
## ----------
# fly upgrade
# fly install $CLI_APPS
# fly lamp
# fly phpmyadmin
# fly phpize
# fly fishell
# fly php_composer
# fly phpmongo