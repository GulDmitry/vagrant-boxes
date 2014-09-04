class tools::phpmyadmin {

  package { "phpmyadmin":
    ensure => present,
    require => Exec["apt-get update"]
  }

  file { "/etc/apache2/conf.d/phpmyadmin.conf":
    ensure => link,
    target => "/etc/phpmyadmin/apache.conf",
    require => Package["phpmyadmin"],
    notify => Service["apache2"]
  }
}
