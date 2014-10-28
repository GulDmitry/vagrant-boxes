class nginx {
  package { [ 'nginx' ]:
    ensure  => installed,
    require => Exec['apt-get update'],
  }

  file { '/etc/nginx/nginx.conf':
    require => Package['nginx'],
    source  => 'puppet:///modules/nginx/nginx.conf'
  }

  file { 'nginx/sites-available':
    path    => '/etc/nginx/sites-available',
    ensure  => directory,
    owner   => root,
    group   => root,
    purge   => true,
    recurse => true,
    source  => "puppet:///modules/nginx/sites-available",
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled/webroot':
    ensure  => 'link',
    target  => '/etc/nginx/sites-available/webroot',
    require => File['nginx/sites-available'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    require   => Package['nginx'],
    subscribe => [
      File['/etc/nginx/sites-enabled/webroot']
    ],
  }
}