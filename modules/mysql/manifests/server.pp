class mysql::server {
  include mysql::repo
  include mysql::server::pre_config
  include mysql::server::config
  include mysql::server::install
  include mysql::server::service

  Class['mysql::repo'] -> Class['mysql::server::pre_config'] ->
  Class['mysql::server::install'] -> Class['mysql::server::config'] ~>
  Class['mysql::server::service']

  # Make sure any changes to pre_config notify service.
  Class['mysql::server::pre_config'] ~> Class['mysql::server::service']
}
