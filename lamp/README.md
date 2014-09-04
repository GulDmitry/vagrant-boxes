# LAMP Stacks Made Easy with Vagrant & Puppet

## Box
* Ubuntu 14.04
* Puppet 3.6

## Instructions
1. Open up terminal, change directory to the git repo root, and start the vagrant box.

    $ vagrant up

You're all set up. The webserver will now be accessible from http://localhost:8888

## System Package include
* apache 2.4 - rewrite mode enabled, having virtual host with config - refer manifest/vagrant_webroot.sample
* php5 5.5.x
* php5-cli
* php5-mysql
* php-pear - installed packages: phpunit and its dependencies
* php5-dev
* php5-gd
* php5-mcrypt
* libapache2-mod-php5
* mysql-server
* xdebug
* phpmyadmin
* curl
* vim
* htop
* mc
