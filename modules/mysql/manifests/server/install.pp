class mysql::server::install {
  package{'Percona-Server-server-56':
      ensure  => 'present',
  }
}
