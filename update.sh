#!/bin/bash

export GIT_EDITOR=vi
cd /data

# GIT

git remote add origin http://github.com/markweinberg/MF.git
git pull origin master

# NGINX

echo Starting nginx... 

nginx -s stop
nginx -c /data/nginx/nginx.conf

# PHP5_FPM

echo Restarting PHP5-FPM...

sudo service php5-fpm restart
