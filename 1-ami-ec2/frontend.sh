#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\
sudo apt-get install -y nodejs -y
sudo apt update -y
sudo npm install -g corepack -y
corepack enable
corepack prepare yarn@stable --activate --yes
sudo yarn global add pm2
