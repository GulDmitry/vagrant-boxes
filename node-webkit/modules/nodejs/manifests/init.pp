class nodejs {
  package { ['python-software-properties', 'g++', 'make', 'git-core']:
    require => Exec['apt-get update'],
    ensure  => latest,
  }

  file { '/opt/node':
    ensure  => 'link',
    target  => '/vagrant',
    force   => true,
  }

  file { '/tmp/install-nodejs.sh':
    ensure  => present,
    mode    => '0775',
    source  => 'puppet:///modules/nodejs/install-nodejs.sh',
    require => Package['python-software-properties', 'g++', 'make', 'git-core']
  }

  exec { 'install-nodejs':
    command => '/tmp/install-nodejs.sh',
    path    => '/usr/bin:/usr/local/bin:/bin:/usr/sbin:/sbin',
    timeout => 0,
    unless  => 'ls /usr/local/bin/node',
    require => File['/tmp/install-nodejs.sh']
  }

}
