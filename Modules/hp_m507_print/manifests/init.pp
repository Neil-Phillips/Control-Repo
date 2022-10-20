#
class hp_m507_print {

  file { '/usr/local/bin/ResetPrinters.sh':
    owner  => root,
    group  => root,
    mode   => '0755',
#    source => "puppet:///modules/hp_m507_print/ResetPrinters.sh.epos"
    content => template('hp_m507_print/ResetPrinters.sh.epos.erb')
  }

  file { "/etc/cups/ppd/hp_laserjet_m507.ppd":
    owner   => root,
    source  => "puppet:///modules/hp_m507_print/hp_laserjet_m507.ppd"
  }

  file { "/etc/cups/ppd/hp_laserjet_m406.ppd":
    owner   => root,
    source  => "puppet:///modules/hp_m507_print/hp_laserjet_m507.ppd"
  }

}
