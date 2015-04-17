export GIT_EDITOR=vi
cd /
mkdir /data
cd data

# GIT

#apt-get install git
git init
git remote add origin http://github.com/markweinberg/MF.git
git pull origin master

# Setup nginx

apt-get install nginx
nginx -s stop
nginx -c /data/nginx/nginx.conf

