# == Class: mysql::server::config
#
# Sets a random password for the root user if one isn't already set and
# saves it to /root/.my.cnf
#
# Also sets up managing of /etc/mysql/conf.d for configuration snippets
# which can be in addition to or override what ever is in the main config.
#
class mysql::server::config {

  # We generate a random root password if one one already isn't set
  $root_password = mysql_gen_password()

  exec {'set_mysql_root_password':
    command => "mysqladmin -u root password '${root_password}'",
    unless  => "mysqladmin -u root -p'${root_password}' status > /dev/null",
    creates => '/root/.my.cnf', # Don't run if this file exists
  }

  file { '/root/.my.cnf':
    content => template('mysql/my.cnf.pass.erb'),
    require => Exec['set_mysql_root_password'],
    replace => false, # Do not replace if already exists
  }

  # We manage everything in /etc/mysql/conf.d:
  file { '/etc/mysql/conf.d':
    ensure  => 'directory',
    mode    => '0755',
    purge   => true, # Purge any files that are not managed by resources
    recurse => true,
  }
}
