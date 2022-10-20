#
class filebeat::config::ossec inherits filebeat {

  file { "/etc/filebeat/conf.d/ossec.yml":
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package["filebeat"],
    notify  => Service["filebeat"],
    content => template('filebeat/ossec.yml.erb'),
  }
  
}
