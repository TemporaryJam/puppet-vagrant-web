# == Class: mysql::server::service
#
# Make sure mysql is running
#
class mysql::server::service {
  service{'mysql':
      ensure      => running,
      enable      => true,
      hasstatus   => true,
  }
}
