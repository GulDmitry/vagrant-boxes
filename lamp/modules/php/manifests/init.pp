class php {

  # package install list
  $packages = [
    "php5",
    "php5-cli",
    "php5-mysql",
    "php-pear",
    "php5-dev",
    "php5-gd",
    "php5-mcrypt",
    "libapache2-mod-php5",
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  # create directory
  file {"/etc/php5/conf.d":
    ensure => directory,
    require => Package["php5"],
  }

  # Update config.
  file {'/etc/php5/conf.d/local.ini':
    path => '/etc/php5/conf.d/local.ini',
    ensure => present,
    require => Package["php5"],
    owner => root, group => root, mode => 444,
    content => "
      post_max_size = 16M
      upload_max_filesize = 16M
      memory_limit = 512M
      error_reporting = E_ALL
      html_errors = On
      display_errors = On
    ",
  }

}
