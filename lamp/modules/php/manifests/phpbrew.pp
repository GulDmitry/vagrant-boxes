#
# https://github.com/phpbrew/phpbrew
#
class php::phpbrew (
  $version = false
) {
  $user = 'vagrant'
  $home_dir = "/home/${$user}"

  $dependencies = [
    'autoconf',
    'automake',
    'curl',
    'build-essential',
    'libxslt1-dev',
    're2c',
    'libxml2-dev',
    'libmcrypt-dev',
    'bzip2',
    'libbz2-dev',
    'libreadline-dev',
  ]

  package { $dependencies:
    ensure  => present,
    require => Package['php5'],
    before  => Exec['download phpbrew'],
  }

  exec { 'download phpbrew':
    command => 'curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew',
    cwd     => "${$home_dir}",
    creates => "$home_dir/phpbrew",
    require => Package['curl'],
  }

  file { '/home/vagrant/phpbrew':
    mode    => 'a+x',
    require => Exec['download phpbrew'],
  }

  file { '/usr/bin/phpbrew':
    source  => "$home_dir/phpbrew",
    require => File['/home/vagrant/phpbrew'],
  }

  exec { 'init phpbrew':
    command     => '/usr/bin/phpbrew init',
    user        => $user,
    cwd         => "${$home_dir}",
    environment => "HOME=${$home_dir}",
    creates     => "$home_dir/.phpbrew",
    require     => File['/usr/bin/phpbrew'],
  }

  file_line { 'add phpbrew to bashrc':
    path    => "$home_dir/.bashrc",
    line    => '
    PHPBREW_SET_PROMPT=1
    source /home/vagrant/.phpbrew/bashrc
    ',
    require => Exec['init phpbrew'],
  }

# To use apxs2 apache dir should be writable.
  exec { 'make apache writable':
    command => 'chmod -R og+rw /etc/apache2; chmod a+w /usr/lib/apache2/modules/; chmod a+w /etc/apache2/mods-available/',
    require => Exec['init phpbrew'],
  }

  if $version != false {

  # Command example: phpbrew install php-5.6.5 +default +mb +apxs2 -- --enable-maintainer-zts
  # The 'apxs2' requires the 'apache2-prefork-dev' package.
    exec { "install php-${version}":
      command     => "/usr/bin/phpbrew install php-${version} +default +mb +apxs2",
      user        => $user,
      environment => ["HOME=${$home_dir}", "PHPBREW_ROOT=${$home_dir}/.phpbrew"],
      creates     => "${$home_dir}/.phpbrew/php/php-${version}/bin/php",
      timeout     => 0,
      require     => Exec['make apache writable'],
    }
  # phpbrew switch|use php-$version
  # Restart apache.
  # Reload shell: source ~/.bashrc
  }

}
