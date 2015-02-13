class bootstrap {

# silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

# Replace archive repositories to old-release, needs for Ubuntu 13.
#  exec { 'repair archive repos':
#    command => 'sudo sed -i -e "s/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g" /etc/apt/sources.list'
#  }

# ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  $packages = [
    'software-properties-common',
    'python-software-properties',
  ]

  package { $packages:
    ensure  => present
  }

}
