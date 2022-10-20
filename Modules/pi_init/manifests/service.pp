# Service

class pi_init::service inherits pi_init {

  service { 'puppet':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
