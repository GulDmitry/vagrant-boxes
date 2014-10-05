#!/bin/sh

#
# install upstream phalcon
#
cd /home/vagrant
git clone git://github.com/phalcon/cphalcon.git
cd cphalcon/build/
sudo ./install

#
# phalcon developer tools
#
cd /home/vagrant
git clone git://github.com/phalcon/phalcon-devtools.git
cd phalcon-devtools
sudo ./phalcon.sh