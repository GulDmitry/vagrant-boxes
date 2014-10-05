class php {
  package { ['php5-common', 'php5-gd', 'php5-mcrypt', 'php5-mysql', 'php5-cli', 'php5-curl', 'php5-fpm', 'php-pear' ]:
    require => Exec['apt-get update'],
    ensure  => latest,
  }

  file { 'www.conf':
    path    => '/etc/php5/fpm/pool.d/www.conf',
    ensure  => file,
    owner   => root,
    group   => root,
    source  => '/vagrant/config/php/www.conf',
    require => Package['php5-fpm'],
    notify  => Service['php5-fpm'],
  }

  service { 'php5-fpm':
    ensure  => running,
    enable  => true,
    require => Package['php5-fpm'],
  }

# Update config.
  file { '/etc/php5/mods-available/local.ini':
    path    => '/etc/php5/mods-available/local.ini',
    ensure  => present,
    require => Package["php5-fpm"],
    owner   => root, group => root, mode => 444,
    content => "
      post_max_size = 60M
      upload_max_filesize = 60M
      memory_limit = 800M
      error_reporting = E_ALL
      html_errors = On
      display_errors = On
      date.timezone = Europe/Minsk
    ",
  }

# Symlink on overrided php config file.
  file { "/etc/php5/fpm/conf.d/30-local.ini":
    ensure  => link,
    target  => "/etc/php5/mods-available/local.ini",
    require => File["/etc/php5/mods-available/local.ini"],
    notify  => Service["php5-fpm"],
  }
}