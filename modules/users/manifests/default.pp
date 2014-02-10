class users::default {

  group {'eharth': ensure => 'present'}
  group {'wwweditors': ensure => 'present'}

  user {'eharth':
    home       => '/home/eharth',
    ensure     => 'present',
    gid        => 'eharth',
    groups     => [wheel, wwweditors],
    comment    => 'Eric',
    password   => 'BOGUS_HASH',
    managehome => true,
    require    => Group['eharth'],
  }

  ssh_authorized_key {'eharth':
    ensure  => 'present',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAABJQAAAIEAvB0+RxQ4kEBOAEPR2gdUAlPFfQZzYE7MnJohpDlPRCYbgb+GyvSNUNgaYPEZ/l4H0oSg4IYTSCshjQpep1KZDGditf+YE6CCvENwmt00CyTdNIKOTeKUQab7cm5DhU7c1OWOegDazJdwe8I3bJI4R2Ynt6Kwmq/K8nwY4dSPYTk=',
    user    => 'eharth',
    require => User['eharth'],
  }
}
