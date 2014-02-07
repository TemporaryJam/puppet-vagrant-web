class nginx::repo {
  yum::repo { 'nginx' :
    baseurl => 'http://nginx.org/packages/centos/6/$basearch/',
  }
}
