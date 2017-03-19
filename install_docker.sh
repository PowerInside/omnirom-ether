#!/bin/sh
sudo apt-get update
sudo apt-get install -qy curl
sudo apt-get dist-upgrade -qy
curl -fsSL https://get.docker.com/ | sh
docker build -t omnirom-ether .

