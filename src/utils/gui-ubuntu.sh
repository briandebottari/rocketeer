#!/usr/bin/env 

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