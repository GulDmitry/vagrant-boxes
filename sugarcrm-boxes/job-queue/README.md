## Job-queue box for SugarCRM

## Box
* Ubuntu 13.04 x32.

## Requirements
* Apache 2.2
* PHP 5.4
* xDebug
* MySQL 5.5
* ElasticSearch 0.9.x

* Gearman
* RabbitMQ 3.4.1 (php-amqp ext 1.4.0)

## Tips
* Gearman service `sudo service gearman-job-server`
* Rabbit service `sudo service rabbitmq-server`
* Rebbit management plubin `http://server-name:15672`, a new admin user `admin - admin`
* Clean rabbit queue `sudo rabbitmqctl stop_app; sudo rabbitmqctl reset; sudo rabbitmqctl start_app`
* Sugar config:
```
$sugar_config['sugar_queue']['manager'] = 'standard';
//$sugar_config['sugar_queue']['manager'] = 'parallel';

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
```
* Check the pcntl ext `php -r 'echo extension_loaded("pcntl") ? "yes\n" : "no\n";'`
