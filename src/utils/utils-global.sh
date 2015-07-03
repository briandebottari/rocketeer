#!/usr/bin/env bash

function docker() {
    curl -Ss https://get.docker.io/ubuntu/ > docker.sh
    sudo bash docker.sh
}