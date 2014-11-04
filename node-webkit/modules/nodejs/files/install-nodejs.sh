#!/bin/bash -x
version=0.10.33

if [ $(which node | grep node | wc -l) == "0" ]
then
    cd /tmp

    if [ ! -f /tmp/node-v${version}.tar.gz ]; then
        if [ -f /vagrant/modules/nodejs/files/node-v${version}.tar.gz ]; then
            cp /vagrant/modules/nodejs/files/node-v${version}.tar.gz /tmp/node-v${version}.tar.gz
        else
            wget -N http://nodejs.org/dist/v${version}/node-v${version}.tar.gz
        fi
    fi

    tar xzvf node-v${version}.tar.gz && cd node-v${version}
    ./configure
    sudo make install
fi
