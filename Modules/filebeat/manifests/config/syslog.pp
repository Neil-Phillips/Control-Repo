#
class filebeat::config::syslog inherits filebeat {

  if $::hostname != 'logstash' {

    file { "/etc/filebeat/conf.d/syslog.yml":
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package["filebeat"],
      notify  => Service["filebeat"],
      content => template('filebeat/syslog.yml.erb'),
    }

  }
  
}
