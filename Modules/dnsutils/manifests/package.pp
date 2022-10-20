#
class dnsutils::package inherits dnsutils {

  package { 'dnsutils':
    ensure => present,
#    install_options   => ['--force-yes'],
#  }
#  if ( $lsbdistrelease != '12.04' ) {
#    package { 'netcat':
#      ensure => present,
##    install_options   => ['--force-yes'],
#    }
  }
}
