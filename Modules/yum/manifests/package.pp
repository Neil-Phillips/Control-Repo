#
class yum::package inherits yum {

      # Install yum-cron package
      package { 'yum-cron':
        ensure => latest,
        install_options   => ['--force-yes'],
	    notify  => Exec["yum-update"],
      }

    # Start and enable the service
    exec { "yum-update":
      command     => "/bin/systemctl start yum-cron ; /bin/systemctl enable yum-cron",
      logoutput   => false,
      refreshonly => true,
    }


}
