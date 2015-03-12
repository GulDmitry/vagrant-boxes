## Job-queue box for SugarCRM

## Box
* Ubuntu 14.

## Requirements
* Apache 2.x (system)
* PHP 5.x (system)
  * xDebug
* [Phpbrew](https://github.com/phpbrew/phpbrew)
  * Switching php5 apache module read [here](https://github.com/phpbrew/phpbrew/wiki/Cookbook#apache2-support).
* MySQL 5.x
* PHPMyAdmin
* ElasticSearch 0.9.x

* Gearman
* RabbitMQ 3.4.1 (php-amqp ext 1.4.0)

## Tips
* Mysql user `root` pswd `root` db `sugarcrm` 
* Gearman
 * To connect use private IP from Vagrantfile.
 * `sudo service gearman-job-server`
 * (echo workers ; sleep 0.1) | netcat 127.0.0.1 4730
 * (echo status ; sleep 0.1) | netcat 127.0.0.1 4730
 * sudo  gearmand --queue-type=MySQL --mysql-host=localhost --mysql-user=root --mysql-password=root --mysql-db=sugarcrm
   --mysql-port=3306 --mysql-table=gearman_01 --log-file=/var/log/gearmand.log
* Rabbit
 * Rabbit service `sudo service rabbitmq-server`
 * Rabbit management plugin `http://server-name:15672`, a new admin user `admin - admin`
 * For remote connection to Rabbit, say from your php-script, use `admin - admin`
 * Clear rabbit queue `sudo rabbitmqctl stop_app; sudo rabbitmqctl reset; sudo rabbitmqctl start_app`
* Sugar config:
```
$sugar_config['sugar_queue']['manager'] = 'standard';
//$sugar_config['sugar_queue']['manager'] = 'parallel';

// Lock isn't used.
//$sugar_config['sugar_queue']['mode']['od'] = true;

// Sugar
$sugar_config['sugar_queue']['queue'] = 'sugar';

// Gearman
//$sugar_config['sugar_queue']['queue'] = 'gearman';
//$sugar_config['sugar_queue']['servers'] = '127.0.0.1:4730';

// AMQP
//$sugar_config['sugar_queue']['queue'] = 'amqp';
//$sugar_config['sugar_queue']['servers'] = 'localhost';
//$sugar_config['sugar_queue']['login'] = 'guest';
//$sugar_config['sugar_queue']['password'] = 'guest';

// SQS
//$sugar_config['sugar_queue']['queue'] = 'sqs';
//$sugar_config['sugar_queue']['key'] = '{key}';
//$sugar_config['sugar_queue']['secret'] = '{secret}';
//$sugar_config['sugar_queue']['region'] = 'eu-west-1';
//$sugar_config['sugar_queue']['queueName'] = 'sugarjobqueue_dev';

// Queue executes tasks on add.
//$sugar_config['sugar_queue']['queue'] = 'immediate';

// Otherwise Sugar selects enabled backend according to priority.
//$sugar_config['sugar_queue']['logger'] = 'ClassName';

```
* Check the pcntl ext `php -r 'echo extension_loaded("pcntl") ? "yes\n" : "no\n";'`
