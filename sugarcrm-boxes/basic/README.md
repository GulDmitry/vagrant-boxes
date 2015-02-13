## Basic box for SugarCRM

## Box
* Ubuntu 14.

## Requirements
* Apache 2.x (system)
* PHP 5.x (system)
  * xDebug
* [Phpbrew](https://github.com/phpbrew/phpbrew)
* MySQL 5.5
* PHPMyAdmin
* ElasticSearch 0.9.x

## Tips
* Mysql user `root` pswd `root` db `sugarcrm` 
* PHP 5.3.29 is preinstalled. To enable it execute:
  * phpbrew use|switch php-5.3.29
  * sudo service apache2 restart

## TODO
* Waiting until RSYNC become two-way. The "vagrant-rsync-back" can be used to sync from guest to host but
in pair with "rsync-auto" it makes developing process uncomfortable.
Follow the discussion https://github.com/mitchellh/vagrant/issues/3062
