#
class apt::update inherits apt {

#      tidy { 'run-apt-update-weekly':
#        path => '/var/lib/apt/periodic/update-stamp',
#        size => '0',
#	age => '4w',
#	notify  => Exec["apt-apt-update"],
#      }
##      file { '/var/lib/apt/periodic/update-stamp':
##        owner    => root,
##        group    => root,
##        mode     => '0644',
##        content => "# Managed by Puppet changes will be lost\n",
##        notify  => Exec["apt-apt-update"],
##      }

#      tidy { 'stale-apt-lock':
#        path => '/var/lib/apt/lists/lock',
#        size => '0',
#        age => '4w',
#       notify  => Exec["apt-apt-update"],
#      }


  if $proxy_url != '' {
    file { "/etc/apt/apt.conf":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      notify  => Exec["apt-apt-update"],
      content => "# Managed by Puppet changes will be lost\n\nAcquire::http::Proxy \"$proxy_url\";\nAcquire::https::Proxy \"$proxy_url\";\n",
    }
  } else {
    file { "/etc/apt/apt.conf":
      ensure  => absent,
      notify  => Exec["apt-apt-update"],
    }
  }
  if $_fullname =~ 'laptop' or $_fullname =~ 'till' or $_fullname =~ 'manager' or $_fullname =~ 'tos31966-laurencebrowne' or $_fullname =~ 'tos30714-office' or $_fullname =~ 'tos30536-office' or $override {
    file { '/etc/apt/sources.list':
      ensure  => file,
      owner   => root,
      group   => root,
      notify  => Exec['apt-apt-update'],
      mode    => '0664',
      content => template('apt/sources.list.erb'),
    }
  }
  file { '/etc/apt/apt.conf.d/10-puppetlabs':
    ensure  => absent,
    notify  => Exec['apt-apt-update'],
  }

# do an apt update
    exec { "apt-apt-update":
      command     => "/bin/sh -c '/usr/bin/dpkg --configure -a ; /usr/bin/apt-get update ; touch /var/lib/apt/periodic/update-stamp'",
      logoutput   => false,
      refreshonly => true,
    }
}
