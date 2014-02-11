# == Class: mysql::repo
#
# Add the percona repo
#
class mysql::repo {
  yumrepo {'Percona':
    baseurl    => 'http://repo.percona.com/centos/$releasever/os/$basearch/',
    gpgcheck   => '1',
    enabled    => '1',
    gpgkey     => 'http://www.percona.com/downloads/RPM-GPG-KEY-percona',   
  }

  
}
