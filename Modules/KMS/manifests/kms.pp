# KMS Desktop Icon
class kms {
  package { 'google-chrome-stable':
    ensure  => installed,
  }

  file { '/usr/share/applications/kms.desktop':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/kms/kms.desktop',
  }

  file { '/usr/local/bin/kms.sh':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/kms/kms.sh',
  }

  file { '/usr/share/pixmaps/kms.png':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/kms/kms.png',
  }

  file { '/etc/apt/sources.list.d/google-chrome.list':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/kms/google-chrome.list',
    notify => Package['google-chrome-stable'],
  }
}
