class phalcon::install {
  package { ['git-core', 'gcc', 'autoconf', 'libpcre3-dev', 'unzip']:
    require => Exec['apt-get update'],
    ensure  => latest,
  }

  file { '/tmp/cphalcon-master.zip':
    ensure  => file,
    source  => 'puppet:///modules/phalcon/cphalcon-master.zip',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
    require => Package['unzip'],
  }

  file { '/tmp/phalcon-devtools-master.zip':
    ensure  => file,
    source  => 'puppet:///modules/phalcon/phalcon-devtools-master.zip',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
    require => Package['unzip'],
  }

  file { '/tmp/install-phalcon.sh':
    ensure  => file,
    source  => 'puppet:///modules/phalcon/install-phalcon.sh',
#    source  => 'puppet:///modules/phalcon/install-latest-phalcon.sh',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
    require => Package['git-core', 'php5-fpm', 'php5-dev', 'libpcre3-dev', 'gcc'],
  }

  notify { 'Phalcon script has been installed successfully' :
    require => File['/tmp/install-phalcon.sh']
  }

  exec { 'install-phalcon-sh':
    command  => '/tmp/install-phalcon.sh',
    require  => File['/tmp/install-phalcon.sh', '/tmp/phalcon-devtools-master.zip', '/tmp/cphalcon-master.zip'],
  #    require  => File['/tmp/install-phalcon.sh'],
    provider => 'shell',
    unless   => '/bin/ls -a /usr/lib/php5/* | /bin/grep -c phalcon.so',
  }

  file { '/etc/php5/mods-available/phalcon.ini':
    path    => '/etc/php5/mods-available/phalcon.ini',
    ensure  => present,
    owner   => root, group => root, mode => 444,
    require => Exec['install-phalcon-sh'],
    content => "extension=phalcon.so",
  }

  exec { 'enable-phalcon-extension':
    command => '/usr/bin/sudo php5enmod phalcon',
    require => File['/etc/php5/mods-available/phalcon.ini'],
    notify  => Service['php5-fpm']
  }

  notify { 'Phalcon ini extension has been written sucessfully' :
    require => File['/etc/php5/mods-available/phalcon.ini']
  }

  file { '/usr/bin/phalcon':
    ensure  => link,
    target  => '/home/vagrant/phalcon-devtools/phalcon.php',
    require => Exec['install-phalcon-sh'],
    notify  => Service['php5-fpm']
  }

  notify { 'Phalcon DevTools added to path' :
    require => File['/usr/bin/phalcon']
  }

}

class phalcon::configure {
}
