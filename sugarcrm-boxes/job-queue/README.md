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
// Lock isn't used.
$sugar_config['job_queue']['od'] = true;

// $sugar_config['job_queue']['runner'] = 'standard';
// $sugar_config['job_queue']['runner'] = 'parallel';

// Sugar
$sugar_config['job_queue']['adapter'] = 'Sugar';

// Gearman
//$sugar_config['job_queue']['adapter'] = 'Gearman';
//$sugar_config['job_queue']['servers'] = '192.168.50.21';

// AMQP
//$sugar_config['job_queue']['adapter'] = 'AMQP';
//$sugar_config['job_queue']['servers'] = '192.168.50.21';
//$sugar_config['job_queue']['login'] = 'admin';
//$sugar_config['job_queue']['password'] = 'admin';

// SQS
//$sugar_config['job_queue']['adapter'] = 'AmazonSQS';
//$sugar_config['job_queue']['key'] = '{key}';
//$sugar_config['job_queue']['secret'] = '{secret}';
//$sugar_config['job_queue']['region'] = 'eu-west-1';
//$sugar_config['job_queue']['queueName'] = 'sugarjobqueue_dev';

// Queue executes tasks on add.
//$sugar_config['job_queue']['adapter'] = 'Immediate';
```
* Check the pcntl ext `php -r 'echo extension_loaded("pcntl") ? "yes\n" : "no\n";'`
