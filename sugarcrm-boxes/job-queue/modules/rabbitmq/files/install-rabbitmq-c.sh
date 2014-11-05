#!/bin/bash

if [ $(ldconfig -p | grep librabbitmq | wc -l) == "0" ]
then
    mkdir -p /tmp/rabbitmq-c
    tar xzvf /tmp/rabbitmq-c.tar.gz -C /tmp/rabbitmq-c --strip-components 1

    cd /tmp/rabbitmq-c

    sudo autoreconf -i
    sudo ./configure
    sudo make
    sudo make install
fi
