Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include update
include mysql
include nginx
include php
include php::pear
include php::pecl
include php::xdebug
include phalcon
