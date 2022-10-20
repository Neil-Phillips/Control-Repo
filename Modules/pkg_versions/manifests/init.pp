#
class pkg_versions (

  $packages = $pkg_versions::params::packages,

  ) inherits pkg_versions::params {

  file { '/etc/puppetlabs/pkg_versions':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template('pkg_versions/pkg_versions.erb'),
  }

}

