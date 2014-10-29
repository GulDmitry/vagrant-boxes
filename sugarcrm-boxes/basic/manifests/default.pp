# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include bootstrap
include tools
include apache
include php
include php::pear
include php::pecl
include php::xdebug
include mysql
include tools::phpmyadmin
include elasticsearch::install
include elasticsearch::configure

