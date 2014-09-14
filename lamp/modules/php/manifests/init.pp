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
    "php5-curl",
    "libapache2-mod-php5",
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

  # create directory
  file {"/etc/php5/mods-available":
    ensure => directory,
    require => Package["php5"],
  }

  # Update config.
  file {'/etc/php5/mods-available/local.ini':
    path => '/etc/php5/mods-available/local.ini',
    ensure => present,
    require => Package["php5"],
    owner => root, group => root, mode => 444,
    content => "
      post_max_size = 60M
      upload_max_filesize = 60M
      memory_limit = 800M
      error_reporting = E_ALL
      html_errors = On
      display_errors = On
    ",
  }

  # Symlink on overrided php config file.
  file { "/etc/php5/apache2/conf.d/30-local.ini":
    ensure => link,
    target => "/etc/php5/mods-available/local.ini",
    require => File["/etc/php5/mods-available/local.ini"],
    notify => Service["apache2"],
  }

}
