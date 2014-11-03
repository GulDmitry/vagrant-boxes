class nodejs {
  package { ['python-software-properties', 'g++', 'make', 'git-core', 'vim']:
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
    source  => 'puppet:///modules/nodejs/install-latest-nodejs.sh',
    require => Package[$nodejs_deps]
  }

  exec { 'install_node':
    command => '/bin/bash /tmp/deploy_node.sh',
    path    => '/usr/bin:/usr/local/bin:/bin:/usr/sbin:/sbin',
    timeout => 0,
    unless  => 'ls /usr/local/bin/node ',
    require => File['/tmp/install-nodejs.sh']
  }

  exec { 'npm_install':
    cwd     => '/opt/node',
    command => 'npm install',
    path    => '/usr/bin:/usr/local/bin:/bin:/usr/sbin:/sbin',
    require => Exec['install_node']
  }

}
