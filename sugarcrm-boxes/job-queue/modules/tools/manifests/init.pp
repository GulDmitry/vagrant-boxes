class tools {

# package install list
  $packages = [
    'vim',
    'htop',
    'mc'
  ]

# install packages
  package { $packages:
    ensure  => present,
    require => Exec['apt-get update']
  }
}
