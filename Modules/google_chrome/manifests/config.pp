class google_chrome::config() inherits google_chrome {



  file { $google_chrome::defaults_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('google_chrome/defaults-google-chrome.epp', {
      proxy_pac_url => $google_chrome::defaults_proxy_pac_url,
    }),
  }

  $_desc  = 'google-chrome'
  $chrome_repo = 'dl.google.com'
#}

if $proxy_url != undef {
    $_command = "/bin/sh -c 'export http_proxy=\"http://${proxy_url}\"; export https_proxy=\"http://${proxy_url}\";"
  }
  else {
    $_command = "/bin/sh -c '"
  }

  exec { 'chrome-key':
    command     => "${_command} /usr/bin/wget -q https://dl.google.com/linux/linux_signing_key.pub -O- |apt-key add - ; unset http_proxy ; unset https_proxy ;/usr/bin/apt-get update'",
    logoutput   => false,
    refreshonly => true,
    notify      => Exec['chrome-apt-update'],
  }

  file { '/etc/apt/sources.list.d/google-chrome.list':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Exec['chrome-key'],
#    content => "# Managed by Puppet changes will be lost\n\n# Google Chrome repo\n\ndeb [arch=amd64] http://${chrome_repo}/linux/chrome/deb stable main",
    content => "### THIS FILE IS AUTOMATICALLY CONFIGURED ###\n\n# You may comment out this entry, but any other modifications may be lost.\ndeb [arch=amd64] http://${chrome_repo}/linux/chrome/deb/ stable main\n\n",
  }

  if $proxy_url != undef {

    file { "/etc/apt/apt.conf.d/00proxy-${_desc}":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      notify  => Exec["chrome-apt-update"],
      content => "# Managed by Puppet changes will be lost\n\nAcquire::http::Proxy::${chrome_repo} \"http://${proxy_url}\";",
    }
  } else {
      file { "/etc/apt/apt.conf.d/00proxy-${_desc}":
        ensure  => absent,
        notify  => Exec["chrome-apt-update"],
   }
  }

  exec { 'chrome-apt-update':
    command     => "/bin/sh -c '/usr/bin/apt-get update'",
    logoutput   => false,
    refreshonly => true,
  }


}
