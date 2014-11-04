class node-webkit {
  package { [
#    'chromium-browser'
  ]:
    require => Exec['apt-get update'],
    ensure  => latest,
  }

  file { '/tmp/node-webkit.tar.gz':
    ensure  => present,
    mode    => '0775',
    source  => 'puppet:///modules/node-webkit/node-webkit-v0.10.5-linux-x64.tar.gz',
  }

  exec { 'install-node-webkit':
    command => 'tar xzvf /tmp/node-webkit.tar.gz -C /vagrant/webroot',
    timeout => 0,
    require => File['/tmp/node-webkit.tar.gz'],
  }

}
