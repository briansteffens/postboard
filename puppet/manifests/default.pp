Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class ready {
  exec { 'apt-get update':
    command => 'apt-get update',
  }

  # Optional: attempts to use a local package cache for aptitude.
  package { "squid-deb-proxy-client":
    ensure  => present,
    require => Exec["apt-get update"],
  }
}

class { 'ready': }

# Install MySQL
class { "::mysql::server":
  require => Class['ready'],
  root_password => '',
}

# Dependencies
package { [ 'libmysqlclient-dev', 'nodejs' ]:
  ensure => present,
  require => Class['ready'],
}

# Install rbenv
rbenv::install { "vagrant":
  group => 'vagrant',
  home  => '/home/vagrant',
}

# Get Ruby 2.2.2
rbenv::compile { "2.2.2":
  user => "vagrant",
  global => true,
}

# Get Rails and the MySQL adapter.
rbenv::gem { ['rails', 'mysql2']:
  user => 'vagrant',
  ruby => '2.2.2',
}
