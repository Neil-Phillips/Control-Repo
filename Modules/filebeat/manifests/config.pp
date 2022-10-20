#
class filebeat::config inherits filebeat {

  $filebeat_crt = $filebeat::params::crt
  $filebeat_key = $filebeat::params::key
  $filebeat_ca  = $filebeat::params::ca

  file { "/etc/filebeat/conf.d":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package["filebeat"],
  }
 
  file { "/etc/filebeat/ssl":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package["filebeat"],
  }
 
  file { "/var/log/filebeat":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package["filebeat"],
  }
 
  file { "/etc/filebeat/filebeat.yml":
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package["filebeat"],
    notify  => Service["filebeat"],
    content => template('filebeat/filebeat.yml.erb'),
  }
  
  file { "${logstash_crt}":
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/filebeat/${filebeat_crt}"
  }

  file { "${logstash_key}":
    owner  => root,
    group  => root,
    mode   => '0640',
    source => "puppet:///modules/filebeat/${filebeat_key}"
  }

  file { "${logstash_ca}":
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/filebeat/${filebeat_ca}"
  }


}
