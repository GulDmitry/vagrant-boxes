#!/bin/bash

# update apt.
# Commented because goes after puppet.
# sudo apt-get update

if [ $(dpkg-query -l | grep elasticsearch | wc -l) == "0" ]
then
    # install java
    sudo apt-get install openjdk-7-jre-headless -y

    # install elasticsearch
    # wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.13.deb
    sudo dpkg -i /vagrant/webroot/files/elasticsearch-0.90.13.deb
    sudo service elasticsearch start

    # install head
    sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
fi
