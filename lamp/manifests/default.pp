# default path
Exec {
  path => ['/usr/bin', '/bin', '/usr/sbin', '/sbin', '/usr/local/bin', '/usr/local/sbin']
}

include bootstrap
include apache
include php
include php::pear
include php::pecl
include php::xdebug
include php::phpbrew
#class {'php::phpbrew':
#  version => '5.6.5',
#}
include mysql
include tools
include tools::phpmyadmin
#include memcached
