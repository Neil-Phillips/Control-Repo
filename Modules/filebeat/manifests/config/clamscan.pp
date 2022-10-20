#
class filebeat::config::clamscan inherits filebeat {

  if $::hostname != 'logstash' {

    file { "/etc/filebeat/conf.d/clamscan.yml":
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package["filebeat"],
      notify  => Service["filebeat"],
      content => template('filebeat/clamscan.yml.erb'),
    }

  }
  
}
