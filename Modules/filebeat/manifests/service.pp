# Service

class filebeat::service inherits filebeat {

  service { 'filebeat':
    ensure     => stopped,
    enable     => false,
    hasstatus  => true,
    hasrestart => true,
    require    => Package["filebeat"],
  }

}
