class bootstrap {

# silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

# Replace archive repositories to old-release
  exec { 'repair archive repos':
    command => 'sed -i -e "s/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g" /etc/apt/sources.list'
  }

# ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
}
