class nginx::repo {
  yumrepo { 'nginx' :
    baseurl => 'http://nginx.org/packages/centos/6/$basearch/',
    enabled => '1',
    gpgcheck => '0',
  }
}
