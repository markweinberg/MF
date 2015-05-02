#!/bin/bash

function IsPackageInstalled()
{
   PKG_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")

   if [ "install ok installed" == "$PKG_INSTALLED" ]
   then
      echo "true"
   else
      echo "false"
   fi
}

export GIT_EDITOR=vi
cd /
mkdir /data
cd data

# GIT

GIT_INSTALLED=$(IsPackageInstalled "git")

if [ "$GIT_INSTALLED" == "false" ]
then
   echo Installing git...
   apt-get install git 
   git init
else
   echo "git installed"
fi

git remote add origin http://github.com/markweinberg/MF.git
git pull origin master

# NGINX

echo Verifying nginx install...

NGINX_INSTALLED=$(IsPackageInstalled "nginx")

if [ "$NGINX_INSTALLED" == "false" ]
then
   echo Installing nginx...
   apt-get install nginx
else
   echo "nginx installed"
fi

echo Restarting nginx with appropriate config

nginx -s stop
nginx -c /data/nginx/nginx.conf

# PHP5_FPM

PHP5_FPM_INSTALLED=$(IsPackageInstalled "php5-fpm")

if [ "$PHP5_FPM_INSTALLED" == "false" ]
then
   echo Installing php5-fpm
   apt-get install php5-fpm
else
   echo "php5-fpm installed"
fi

echo Restarting PHP5-FPM

sudo service php5-fpm restart

# Add the nginx user to the www-data group. This is necessary to set the
# correct permissions on the /var/run/php5-fpm.sock file (which is how
# nginx communicates with php

echo Connecting nginx and PHP

sudo usermod -aG www-data nginx

