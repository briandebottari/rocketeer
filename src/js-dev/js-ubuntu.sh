#!/usr/bin/env bash

function nodejs012() {
    curl -sL https://deb.nodesource.com/setup_0.12 | sudo -E bash -
    sudo apt-get install -y nodejs
}

function nodejs4x() {
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

