class phalcon::install {
    file { '/tmp/install-phalcon.sh':
        ensure => file,
        source => 'puppet:///modules/phalcon/install-phalcon.sh',
        group => vagrant,
        owner => vagrant,
        mode => 777,
    }

    notify { 'Phalcon script has been installed successfully' : 
            require => File['/tmp/install-phalcon.sh']
    }

    exec { 'install-phalcon-sh':
        command => '/tmp/install-phalcon.sh',
        require => File['/tmp/install-phalcon.sh'],
        provider => 'shell',
        unless => '/bin/ls -a /usr/lib/php5/* | /bin/grep -c phalcon.so',
    }

    file { '/etc/php5/mods-available/phalcon.ini':
        content => 'extension=phalcon.so',
        require => Exec['install-phalcon-sh']
    }

    exec { 'enable-phalcon-extension':
        command => '/usr/bin/sudo php5enmod phalcon',
        require => File['/etc/php5/mods-available/phalcon.ini']
    }

    notify { 'Phalcon ini extension has been written sucessfully' : 
        require => File['/etc/php5/mods-available/phalcon.ini']
    }

    file { '/usr/bin/phalcon':
        ensure => link,
        target => '/home/vagrant/phalcon-devtools/phalcon.php',
        require => Exec['install-phalcon-sh'],
        notify => Service['php5-fpm']
    }

    notify { 'Phalcon DevTools added to path' : 
	require => File['/usr/bin/phalcon']
    }

}

class phalcon::configure {
}

class
{
    include phalcon::install
    include phalcon::configure
}