class default_hostgroup::service inherits default_hostgroup {

  service { 'foreman':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
