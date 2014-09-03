#!/bin/bash
 
# update apt
sudo apt-get update
 
# install java
sudo apt-get install openjdk-7-jre-headless -y
 
# install elasticsearch
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.deb
sudo dpkg -i elasticsearch-1.1.1.deb
sudo service elasticsearch start
 
# install head
sudo /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
