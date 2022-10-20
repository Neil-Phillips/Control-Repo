#
class pi_init::config inherits pi_init {

  file { '/usr/bin/puppet':
    ensure => link,
    target => "/usr/local/bin/puppet",
  }

  file { '/usr/bin/facter':
    ensure => link,
    target => "/usr/local/bin/facter",
  }

  file { "/etc/init.d/puppet":
    owner   => root,
    group   => root,
    mode    => '0755',
    notify  => Service["puppet"],
    source => "puppet:///modules/pi_init/puppet_init"
  }

  file { "/etc/default/puppet":
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/pi_init/puppet_default"
  }

  if $hostgroup =~ /Rastelly/ {
    file_line { 'puppet proxy server':
      ensure => absent,
      path   => '/etc/puppetlabs/puppet/puppet.conf',
      line   => 'http_proxy_host = proxy.aws.toolstation.com',
    }
    file_line { 'puppet proxy port':
      ensure => absent,
      path   => '/etc/puppetlabs/puppet/puppet.conf',
      line   => 'http_proxy_port = 3128',
    }
    file_line { 'puppet port knock old':
      ensure => absent,
      path   => '/etc/puppetlabs/puppet/puppet.conf',
      line   => 'prerun_command="/bin/nc -w1 animal.aws.toolstation.com 61234; sleep 0"',
    }
    file_line { 'puppet port knock new':
      ensure => absent,
      path   => '/etc/puppetlabs/puppet/puppet.conf',
      line   => 'prerun_command = "/bin/nc -w1 animal.aws.toolstation.com 61234; sleep 0"',
    }
    exec { "puppet config set runinterval 5400 --section agent":
      logoutput => false,
      path      => ['/opt/puppetlabs/bin', '/usr/bin',],
      unless    => "/bin/grep 'runinterval = 5400' /etc/puppetlabs/puppet/puppet.conf",
      notify    => Service['puppet'],
    }

  }

  if $::lsbdistrelease == '8.0' {
    file { "/lib/systemd/system/puppet.service":
      owner  => root,
      group  => root,
      mode   => '0640',
      notify  => Exec['puppet_reload'],
      source => "puppet:///modules/pi_init/puppet_service"
    }
  }

  exec { 'puppet_reload':
    command     => "/bin/sh -c '/bin/systemctl daemon-reload'",
    logoutput   => false,
    refreshonly => true,
  }

}

