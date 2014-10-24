#!/bin/bash

if [ $(php -r 'echo extension_loaded("pcntl") ? "1" : "0";') == "0" ]
then
    cd /home/vagrant
    # git clone git://github.com/phalcon/cphalcon.git
    git clone -b master --single-branch git://github.com/phalcon/cphalcon.git
    cd cphalcon/build/
    sudo ./install

    # phalcon developer tools
    cd /home/vagrant
    # git clone git://github.com/phalcon/phalcon-devtools.git
    git clone -b master --single-branch git://github.com/phalcon/phalcon-devtools.git
    cd phalcon-devtools
    sudo ./phalcon.sh
fi
