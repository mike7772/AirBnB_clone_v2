#!/usr/bin/env bash
# This script will sets up your web servers for the deployment of web_static
if ! command -v nginx > /dev/null ;
then
   sudo apt-get update
   sudo apt-get -y install nginx
   sudo ufw --force enable
   sudo ufw allow 'Ngnix HTTP'
fi
if [ ! -d "/data/" ];
then
    sudo mkdir /data/
fi
if [ ! -d "/data/web_static/" ];
then
   sudo mkdir /data/web_static/
fi
if [ ! -d "/data/web_static/releases/" ];
then
    sudo mkdir /data/web_static/releases/
fi
if [ ! -d "/data/web_static/shared/" ];
then
    sudo mkdir /data/web_static/shared/
fi
if [ ! -d "/data/web_static/releases/test/" ];
then
    sudo mkdir /data/web_static/releases/test/
fi
printf "<html>\n  <head>\n  </head>\n  <body>\n    Holberton School\n  </body>\n</html>\n" | sudo tee /data/web_static/releases/test/index.html > /dev/null
if [ -L "/data/web_static/current" ];
then
    sudo unlink /data/web_static/current
fi
sudo ln -s /data/web_static/releases/test /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
sudo sed -ie '0,/location \/ {/s/location \/ {/location \/hbnb_static\/ {\n\t\talias \/data\/web_static\/current\/;/' /etc/nginx/sites-available/default
sudo service nginx restart
