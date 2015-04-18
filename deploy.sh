#!/bin/bash

function IsPackageInstalled()
{
   PKG_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")

   if [ "" == "$PKG_INSTALLED" ]
   then
      return 0 
   else
      return 1
   fi
}

export GIT_EDITOR=vi
cd /
mkdir /data
cd data

# GIT

GIT_INSTALLED=$(IsPackageInstalled "git")

if [ "" == "$GIT_INSTALLED" ]
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

if [ "" == "$NGINX_INSTALLED" ]
then
   echo Installing nginx...
   apt-get install nginx
   nginx -s stop
   nginx -c /data/nginx/nginx.conf
else
   echo "nginx installed"
fi
