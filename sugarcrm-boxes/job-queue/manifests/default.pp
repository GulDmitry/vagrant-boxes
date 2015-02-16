# default path
Exec {
  path => ['/usr/bin', '/bin', '/usr/sbin', '/sbin', '/usr/local/bin', '/usr/local/sbin']
}

include bootstrap
include tools
include apache
include php
include php::pear
include php::pecl
include php::xdebug
include php::phpbrew
# Currently supported version.
#class {'php::phpbrew':
#  version => '5.3.29',
#}
include mysql
include tools::phpmyadmin
include elasticsearch::install
include elasticsearch::configure
include gearman
include rabbitmq
