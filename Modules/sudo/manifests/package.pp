#
class sudo::package inherits sudo {

  package { 'sudo':
    ensure => latest,
    install_options   => ['--force-yes'],
  }
}
