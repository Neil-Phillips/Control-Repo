#
class resolvconf (

  $nameserver = $resolvconf::params::nameserver,

  ) inherits resolvconf::params {

  if $_hostname =~ 'till' or $_hostname =~ 'manager' or $_hostname =~ 'rastelly' or $hostgroup =~ /Rastelly/ or $_hostname =~ 'plasma' or $_hostname =~ 'munki' {
#  if $_hostname =~ 'till1' or $_hostname =~ 'till3' or $_hostname =~ 'till5' or $_hostname =~ 'till7' or $_hostname =~ 'till9' or $_hostname =~ 'rastelly' or $_hostname =~ 'manager' {

    file { '/etc/resolv.conf':
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('resolvconf/resolv.conf.erb')
    }
  }

}
