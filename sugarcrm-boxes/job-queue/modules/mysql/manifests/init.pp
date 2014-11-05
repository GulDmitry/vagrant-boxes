class mysql {

# root mysql password
  $mysqlpw = "root"

#start mysql service
  service { "mysql":
    ensure => running,
  }

# set mysql password
  exec { "set-mysql-password":
    unless  => "mysqladmin -uroot -p$mysqlpw status",
    command => "mysqladmin -uroot password $mysqlpw",
    require => Service["mysql"],
  }

# create directory
  file { "/etc/mysql/conf.d":
    ensure => directory,
  }

# Update config.
  file { '/etc/mysql/conf.d/local.cnf':
    path    => '/etc/mysql/conf.d/local.cnf',
    ensure  => present,
    owner   => root, group => root, mode => 444,
    notify  => Service["mysql"],
    content => "
        [mysqld]
        innodb_buffer_pool_size=1500M
        innodb_additional_mem_pool_size=80M
        innodb_thread_concurrency=8
        innodb_file_io_threads=8
        innodb_lock_wait_timeout=50
        innodb_log_buffer_size=8M
        innodb_flush_log_at_trx_commit=0
        innodb_additional_mem_pool_size=300M
        # Skip reverse DNS lookup of clients
        skip-name-resolve
    ",
  }

# Create a database.
  exec { "create sugarcrm db":
    command =>
      "/usr/bin/mysql -uroot -proot -e \"CREATE DATABASE IF NOT EXISTS sugarcrm CHARACTER SET utf8 COLLATE utf8_general_ci;\"",
    require => Service["mysql"],
  }

}
