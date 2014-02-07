class yum::makecache {
  exec { 'makecache' :
    command => 'yum makecache',
  }
}
