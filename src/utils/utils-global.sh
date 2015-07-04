#!/usr/bin/env bash

function docker() {
    curl -Ss https://get.docker.io/ubuntu/ > docker.sh
    sudo bash docker.sh
}

function sshgen() {
	read -e -p "Enter Your Email:" -i "ovirendo@gmail.com" YOUR_EMAIL
	ssh-keygen -t rsa -b 4096 -C "$YOUR_EMAIL"
	eval "$(ssh-agent -s)"
}