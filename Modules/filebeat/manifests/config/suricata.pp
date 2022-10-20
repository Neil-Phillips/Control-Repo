#
class filebeat::config::suricata inherits filebeat {

  file { "/etc/filebeat/conf.d/suricata.yml":
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package["filebeat"],
    notify  => Service["filebeat"],
    content => template('filebeat/suricata.yml.erb'),
  }
  
}
