# LAMP Stack

## Box
* Ubuntu 14.04

* Apache 2.4
* PHP 5.x
  * Xdebug
* [Phpbrew](https://github.com/phpbrew/phpbrew)
* Mysql
* PHPMyAdmin
* Memcached (disabled)

## Tips
* Install [pthreads](https://github.com/krakjoe/pthreads):
  * phpbrew install php-5.6.5 +default +mb +apxs2 -- --enable-maintainer-zts
  * phpbrew use|switch php-5.6.5
  * sudo service apache2 restart

## TODO
* Tune mysql: forward port, change bind-address to 0.0.0.0 to allow remote connections, and add a new user with grants.
  * config.vm.network :forwarded_port, guest: 3306, host: 8811
  * bind-address=0.0.0.0 in /etc/mysql/my.cnf
  * GRANT ALL on ...
