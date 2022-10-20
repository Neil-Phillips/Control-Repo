#
class chromium::package inherits chromium {

#    if $lsbdistrelease == '18.04' {
      package { 'chromium-browser':
        ensure => 'present',
#        install_options   => ['--force-yes'],
#	notify  => Exec["chromium-apt-update"],
 #      }
    }
      package { 'libnss3-dev':
	ensure => latest,
#        install_options   => ['--force-yes'],
      }
# do an apt update
    exec { "chromium-apt-update":
      command     => "/bin/sh -c '/usr/bin/apt update'",
      logoutput   => false,
      refreshonly => true,
    }
}
