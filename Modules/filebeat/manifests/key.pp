#

class filebeat::key inherits filebeat {

  $_gpg_key = 'GPG-KEY-elasticsearch'

  $url = 'deb https://artifacts.elastic.co/packages/6.x/apt stable main'
  $_proxyurl = 'artifacts.elastic.co'

  file { "${builddir::location}/${_gpg_key}":
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Class['builddir'],
    notify  => Exec['elastic-key'],
    source  => "puppet:///modules/filebeat/${_gpg_key}"
  }

  exec { 'elastic-key':
    command     => "/usr/bin/apt-key add ${builddir::location}/${_gpg_key}",
    require     => Class['builddir'],
    logoutput   => false,
    refreshonly => true,
  }

  file { '/etc/apt/apt.conf.d/11_elastic':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Exec['filebeat-apt-update'],
    content => "# Managed by Puppet changes will be lost\n\n#Acquire::http::Proxy::${_proxyurl} \"http://proxy.aws.toolstation.com:3128\";\n",
  }

  file { '/etc/apt/sources.list.d/filebeat.list':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Exec['filebeat-apt-update'],
    require => Exec['elastic-key'],
    content => "# Managed by Puppet changes will be lost\n\n${url}\n",
  }

  exec { 'filebeat-apt-update':
    command     => "/bin/sh -c '/usr/bin/apt-get update'",
    logoutput   => false,
    refreshonly => true,
  }

}
