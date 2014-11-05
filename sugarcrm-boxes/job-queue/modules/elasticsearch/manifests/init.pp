class elasticsearch::install {
  package { ['openjdk-7-jre-headless']:
    require => Exec['apt-get update'],
    ensure  => latest,
  }

  file { '/tmp/elasticsearch.deb':
    ensure  => file,
    source  => 'puppet:///modules/elasticsearch/elasticsearch.deb',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
  }

  file { '/tmp/bootstrap-elastic.sh':
    ensure  => file,
    source  => 'puppet:///modules/elasticsearch/bootstrap.sh',
    group   => vagrant,
    owner   => vagrant,
    mode    => 777,
    require => Package['openjdk-7-jre-headless'],
  }

  exec { 'install-elasticsearch':
    command  => '/tmp/bootstrap-elastic.sh',
    require  => File['/tmp/elasticsearch.deb', '/tmp/bootstrap-elastic.sh'],
    provider => 'shell',
  }

}

class elasticsearch::configure {

  service { 'elasticsearch':
    ensure    => running,
    enable    => true,
    require   => Exec['install-elasticsearch'],
    subscribe => [
      File['/etc/elasticsearch/elasticsearch.yml'],
    ],
  }

  file { '/etc/elasticsearch/elasticsearch.yml':
    require => Exec['install-elasticsearch'],
    source  => 'puppet:///modules/elasticsearch/elasticsearch.yml',
    notify  => Service['elasticsearch'],
  }

}
