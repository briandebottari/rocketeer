#!/usr/bin/env bash

function nodejs() {
    curl -sL https://deb.nodesource.com/setup |sudo bash -
    sudo apt-get install -y nodejs
}
