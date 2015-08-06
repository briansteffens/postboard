Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

exec { 'apt-get update':
  command => 'apt-get update',
}

package { "squid-deb-proxy-client":
  ensure  => present,
  require => Exec["apt-get update"],
}

class { "::mysql::server":
  require => Package['squid-deb-proxy-client'],
  root_password => 'pass',
}

package { [ 'libmysqlclient-dev', 'nodejs' ]:
  ensure => present,
  require => [ Package['squid-deb-proxy-client'] ],
}

rbenv::install { "vagrant":
  group => 'vagrant',
  home  => '/home/vagrant'
}

rbenv::compile { "2.2.2":
  user => "vagrant",
  global => true,
}

rbenv::gem { ['rails', 'mysql2']:
  user => 'vagrant',
  ruby => '2.2.2',
}
