class apache {

# ensures that mode_rewrite is loaded and modifies the default configuration file
  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load"
  }

# create directory
  file { "/etc/apache2/sites-enabled":
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    before  => File["/etc/apache2/sites-enabled/001-webroot.conf"]
  }

# create apache config from main vagrant manifests
  file { "/etc/apache2/sites-available/webroot":
    ensure => present,
    source  => "puppet:///modules/apache/webroot",
  }

# symlink apache site to the site-enabled directory
  file { "/etc/apache2/sites-enabled/001-webroot.conf":
    ensure  => link,
    target  => "/etc/apache2/sites-available/webroot",
    require => File["/etc/apache2/sites-available/webroot"]
  }

# starts the apache2 service once the packages installed, and monitors changes to its configuration files and reloads if nesessary
  service { "apache2":
    ensure    => running,
    subscribe => [
      File["/etc/apache2/mods-enabled/rewrite.load"],
      File["/etc/apache2/sites-available/webroot"]
    ],
  }
}
