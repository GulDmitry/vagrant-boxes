## Basic box for SugarCRM

## Box
* Ubuntu 14.

## Requirements
* Apache 2.x (system)
* PHP 5.x (system)
  * xDebug
* [Phpbrew](https://github.com/phpbrew/phpbrew)
  * Switching php5 apache module read [here](https://github.com/phpbrew/phpbrew/wiki/Cookbook#apache2-support).
* MySQL 5.5
* PHPMyAdmin
* ElasticSearch 0.9.x

## Tips
* Mysql user `root` pswd `root` db `sugarcrm` 

## TODO
* Waiting until RSYNC becomes two-way. The "vagrant-rsync-back" can be used to sync from guest to host but
in pair with "rsync-auto" it makes developing process uncomfortable.
Follow the discussion https://github.com/mitchellh/vagrant/issues/3062
