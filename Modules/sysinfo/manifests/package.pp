#
class sysinfo::package inherits sysinfo {

  package { 'python3':
    ensure => latest,
#    install_options   => ['--force-yes'],
  }
}
