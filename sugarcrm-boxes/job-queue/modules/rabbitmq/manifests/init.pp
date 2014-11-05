class rabbitmq {

  package { ['gdebi', 'pkg-config']:
    ensure  => present,
    require => Exec['apt-get update'],
  }

  file { '/tmp/rabbitmq.deb':
    ensure  => file,
    source  => 'puppet:///modules/rabbitmq/rabbitmq-server_3.4.1-1_all.deb',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
  }

  exec { 'install-rabbitmq':
    command  => 'gdebi -n /tmp/rabbitmq.deb',
    require  => [Package['gdebi'], File['/tmp/rabbitmq.deb']],
    provider => 'shell',
  }

  exec { 'enable-management-plubin':
    command  => 'sudo rabbitmq-plugins enable rabbitmq_management',
    require  => Exec['install-rabbitmq'],
    provider => 'shell',
  }

#  Since 3.3 guest-guest is not allowed to connect via remote host.
  exec { 'create-admin-user':
    command  => '
      sudo rabbitmqctl add_user admin admin
      sudo rabbitmqctl set_user_tags admin administrator
      sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
    ',
    require  => Exec['install-rabbitmq'],
    provider => 'shell',
  }


  file { '/tmp/rabbitmq-c.tar.gz':
    ensure  => file,
    source  => 'puppet:///modules/rabbitmq/rabbitmq-c-0.5.2.tar.gz',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
  }

  file { '/tmp/install-rabbitmq-c.sh':
    ensure  => file,
    source  => 'puppet:///modules/rabbitmq/install-rabbitmq-c.sh',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
  }

  exec { 'install-rabbitmq-c':
    command  => '/tmp/install-rabbitmq-c.sh',
    timeout  => 0,
    require  => [File['/tmp/install-rabbitmq-c.sh'], File['/tmp/rabbitmq-c.tar.gz'], Package['pkg-config']],
  }

  exec { 'php-amqp-extension':
    command => 'sudo pecl install amqp-1.4.0',
    require => [Package['php-pear', 'php5-dev'], Exec['install-rabbitmq-c']],
    notify  => Service['apache2'],
    returns => [1, 0, ''],
  }

  file { '/etc/php5/mods-available/amqp.ini':
    path    => '/etc/php5/mods-available/amqp.ini',
    ensure  => present,
    owner   => root, group => root, mode => 444,
    require => Exec['php-amqp-extension'],
    content => 'extension=amqp.so',
  }

  file { '/etc/php5/apache2/conf.d/30-amqp.ini':
    ensure  => link,
    target  => '/etc/php5/mods-available/amqp.ini',
    require => File['/etc/php5/mods-available/amqp.ini'],
    notify  => Service['apache2'],
  }
}
