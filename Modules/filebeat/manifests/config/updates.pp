#
class filebeat::config::updates inherits filebeat {

  if $::hostname != 'logstash' {

    file { "/etc/filebeat/conf.d/unattended-updates.yml":
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package["filebeat"],
      notify  => Service["filebeat"],
      content => template('filebeat/unattended-updates.yml.erb'),
    }

  }

}
