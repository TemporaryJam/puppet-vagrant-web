node 'web' {
  include base
  
  include yum
  #yum::repo { 'nginx' :
  #  baseurl => 'http://nginx.org/packages/centos/6/$basearch/',
  #}
  include nginx
  nginx::vhost {'test':}

  nginx::vhost {'local-test':
    ip => '127.0.0.1',
  }

  nginx::vhost {'port-test':
    ip   => '127.0.0.1',
    port => '81',
  }
  
  include mysql::server
}
