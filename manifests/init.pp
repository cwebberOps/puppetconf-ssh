# == Class: ssh
#
class ssh (
  $maxstartups = 10
){

  package {
    'openssh-server':
      ensure => installed
  }

  file {
    '/etc/ssh/sshd_config':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('ssh/sshd_config.erb'),
      require => Package['openssh-server']
  }

  service {
    'sshd':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => File['/etc/ssh/sshd_config']
  }

}
