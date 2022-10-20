# Service

class cron::service inherits cron {
  
  service { 'cron':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
#    require    => Package["cron"],
  }

}
