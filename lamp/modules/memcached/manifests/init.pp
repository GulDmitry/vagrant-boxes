class memcached {

  $packages = [
    'memcached',
  ]

  package { $packages:
    ensure  => present,
    require => Exec['apt-get update'],
  }

  package { ['php5-memcached']:
    ensure  => present,
    require => Exec['apt-get update'],
    notify => Service['apache2'],
  }

}
