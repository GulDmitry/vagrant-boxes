#!/bin/bash

if [ $(php -r 'echo extension_loaded("phalcon") ? "1" : "0";') == "0" ]
then

    # Phalcon
    cd /home/vagrant
    unzip /tmp/cphalcon-master.zip
    cd cphalcon-master/build/
    sudo ./install

    # Phalcon developer tools
    cd /home/vagrant
    unzip /tmp/phalcon-devtools-master.zip
    cd phalcon-devtools-master/
    sudo ./phalcon.sh
fi
