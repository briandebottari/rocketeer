#!/usr/bin/env 

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