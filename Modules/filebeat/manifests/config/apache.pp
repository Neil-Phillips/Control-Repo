#
class filebeat::config::apache inherits filebeat {

  if $::hostname != 'logstash' {

    file { "/etc/filebeat/conf.d/apache.yml":
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package["filebeat"],
      notify  => Service["filebeat"],
      content => template('filebeat/apache.yml.erb'),
    }

  }

}
