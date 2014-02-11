define yum::repo($gpgcheck='0', $enabled='1', $gpgkey='', $baseurl) {
  file { "/etc/yum.repos.d/${title}.repo" :
    content => template('yum/repo.erb'),
    notify => Class['yum::makecache'],
  }
}
