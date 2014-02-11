# == Class: mysql::server::pre_config
#
# This does any configuration of mysql required before
# it actually gets installed.
#
# This is because percona helpfully create all the ibdata/log files
# during install so this config needs to be in place so they are
# created with the right size!
#
class mysql::server::pre_config {
  file {'/etc/mysql':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file {'/etc/mysql/my.cnf':
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('mysql/my.cnf.erb'),
    require => File['/etc/mysql'],
  }
}
