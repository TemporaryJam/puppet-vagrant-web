node 'web' {
  include base
  
  include yum

  yumrepo { 'remi' :
    descr        => "Les RPM de remi pour Fedora $releasever - $basearch",
    mirrorlist   => 'http://rpms.famillecollet.com/enterprise/$releasever/remi/mirror',
    enabled      => 1,
    gpgcheck     => 1,
    gpgkey       => 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi',
    failovermethod => 'priority',
  }

  yumrepo { 'remi-test' :
    descr         => "Les RPM de remi en test pour Fedora $releasever - $basearch",
    mirrorlist    => 'http://rpms.famillecollet.com/enterprise/$releasever/test/mirror',
    enabled       => 0,
    gpgcheck      => 1,
    gpgkey        => 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi',
    failovermethod => 'priority',
  }

  yumrepo { 'remi-php55' :
    descr         => "Les RPM de remi en PHP 5.5 pour Enterprise Linux $releasever - $basearch",
    mirrorlist    => 'http://rpms.famillecollet.com/enterprise/$releasever/php55/mirror',
    enabled       => 1,
    gpgcheck      => 1,
    gpgkey        => 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi',
    failovermethod => 'priority',
  }

  yumrepo { 'mysql56-community' : 
    baseurl       => 'http://repo.mysql.com/yum/mysql-5.6-community/el/5/$basearch/',
    descr         => 'MySQL 5.6 Community Server',
    enabled       => 1,
    gpgcheck      => 0,
    #gpgkey        => '',
  }
  

  # Memcached server (12MB)
  class { "memcached": memcached_port => '11211', maxconn => '2048', cachesize => '12', }

 
  # Imagick
  class { 'imagemagick': }

  class { 'mysql::server':
    config_hash => {
      root_password   => '1234',
      log_error   => '/logs/mysql',
      default_engine  => 'InnoDB'
    }
  }

  # MySQL packages and some configuration to automatically create a new database.
  class { 'mysql': }


  Database {
    require => Class['mysql::server'],
  }

  #$additional_mysql_packages = [ "mysql-devel", "mysql-libs" ]
  $additional_mysql_packages = [ "mysql-community-libs"]
  package { $additional_mysql_packages: ensure => present }

  # PHP useful packages. Pending TO-DO: Personalize some modules and php.ini directy on Puppet recipe.
  php::ini {
    '/etc/php.ini':
          display_errors  => 'On',
          short_open_tag  => 'Off',
          memory_limit  => '256M',
          date_timezone => 'Europe/London'
  }
  include php::cli
  php::module { [ 'devel', 'pear', 'pgsql', 'mbstring', 'xml', 'gd', 'tidy', 'pecl-memcache', 'pecl-imagick', 'pecl-xdebug', 'pecl-redis', 'pecl-amqp', 'pdo', 'soap', 'mysql']: }
  php::zend::ini { 'pecl-xdebug':
      settings => {
          'xdebug.remote_enable'      => 'on',
          'xdebug.remote_handler' => 'dbgp',
          'xdebug.remote_port'     => '9001',
          'xdebug.remote_port'     => '9001',
          'xdebug.remote_connect_back'     => 'on',
      'xdebug.max_nesting_level'     => '250',
      },
      module_path => '/usr/lib64/php/modules/xdebug.so'
  }

  include nginx
  nginx::vhost {'test':}

  nginx::vhost {'local-test':
  }

  nginx::vhost {'port-test':
    port => '81',
  }

  nginx::vhost {'drupal-test':
    port => '82',
    vhost_template => 'drupal',
  }

  nginx::vhost {'b8-test':
    port => '83',
  }

  
  
}
