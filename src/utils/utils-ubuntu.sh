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