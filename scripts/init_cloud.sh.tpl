#!/bin/bash   

function install_dependencies {
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common


    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}

function start_server {
    sudo systemctl start docker

    sudo docker pull tiltedphoques/st-game-server

    sudo docker run -d --restart on-failure -p 10578:10578/udp tiltedphoques/st-game-server -token ${server_password}
}

install_dependencies
start_server