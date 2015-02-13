class mysql {

# root mysql password
  $mysqlpw = "root"

# install mysql server
  package { "mysql-server":
    ensure  => present,
    require => Exec["apt-get update"]
  }

#start mysql service
  service { "mysql":
    ensure  => running,
    require => Package["mysql-server"],
  }

# set mysql password
  exec { "set-mysql-password":
    unless  => "mysqladmin -uroot -p$mysqlpw status",
    command => "mysqladmin -uroot password $mysqlpw",
    require => Service["mysql"],
  }

# create directory
  file { "/etc/mysql/conf.d":
    ensure  => directory,
    require => Package["mysql-server"],
  }

# Update config.
  file { '/etc/mysql/conf.d/local.cnf':
    path    => '/etc/mysql/conf.d/local.cnf',
    ensure  => present,
    require => Package["mysql-server"],
    owner   => root, group => root, mode => 444,
    notify  => Service["mysql"],
    content => "
        [mysqld]
        # 70-80% RAM
        innodb_buffer_pool_size=1000M
        innodb_additional_mem_pool_size=50M
        innodb_thread_concurrency=8
        innodb_file_io_threads=8
        innodb_lock_wait_timeout=50
        innodb_log_buffer_size=8M
        innodb_flush_log_at_trx_commit=0
        innodb_additional_mem_pool_size=256M
        # Skip reverse DNS lookup of clients
        skip-name-resolve
    ",
  }

# Create a database.
  exec { "create sugarcrm db":
    command =>
      "/usr/bin/mysql -uroot -proot -e \"CREATE DATABASE IF NOT EXISTS sugarcrm CHARACTER SET utf8 COLLATE utf8_general_ci;\"",
    require => Exec['set-mysql-password'],
  }

}
