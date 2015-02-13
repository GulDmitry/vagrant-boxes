class gearman {

# package install list
  $packages = [
    'gearman-job-server',
    'libgearman-dev',
  ]

  package { $packages:
    ensure  => present,
# For ubuntu less 14.
#    require => Exec['add-gearman-ppa']
    require => Exec['apt-get update']
  }

  service { 'gearman-job-server':
    ensure  => running,
    enable  => true,
    require => Package['gearman-job-server'],
  }

# For ubuntu less 14.
#  exec { 'add-gearman-ppa':
#    command => 'add-apt-repository ppa:gearman-developers/ppa',
#    require => Package['software-properties-common', 'python-software-properties'],
#    notify  => Exec['apt-get update'],
#  }

  exec { 'gearman-php-extension':
    command => 'sudo pecl install gearman',
    require => Package['php-pear', 'php5-dev'],
    notify  => Service['apache2'],
    returns => [1, 0, ''],
  }

  file { '/etc/php5/mods-available/gearman.ini':
    path    => '/etc/php5/mods-available/gearman.ini',
    ensure  => present,
    owner   => root, group => root, mode => 444,
    require => Exec['gearman-php-extension'],
    content => 'extension=gearman.so',
  }

  file { '/etc/php5/apache2/conf.d/30-gearman.ini':
    ensure  => link,
    target  => '/etc/php5/mods-available/gearman.ini',
    require => File['/etc/php5/mods-available/gearman.ini'],
    notify  => Service['apache2'],
  }

# Allow gearman to use remote connections.
  file { '/etc/default/gearman-job-server':
    path    => '/etc/default/gearman-job-server',
    ensure  => present,
    require => Package['gearman-job-server'],
    content => '
        # PARAMS="--listen=127.0.0.1"
        PARAMS=""
    ',
    notify  => Service['gearman-job-server'],
  }

}
