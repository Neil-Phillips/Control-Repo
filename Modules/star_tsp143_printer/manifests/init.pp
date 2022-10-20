#
class star_tsp143_printer {

  file { "/usr/lib/cups/filter/rastertostar":
    owner => root,
    group => root,
    mode => '0755',
    source  => "puppet:///modules/star_tsp143_printer/filters/star/rastertostar"
  }

  file { "/usr/lib/cups/filter/rastertostarlm":
    owner => root,
    group => root,
    mode => '0755',
    source  => "puppet:///modules/star_tsp143_printer/filters/star/rastertostarlm"
  }

  file { "/usr/lib/cups/filter/rastertostarm":
    owner => root,
    group => root,
    mode => '0755',
    source  => "puppet:///modules/star_tsp143_printer/filters/star/rastertostarm"
  }

  file { "/etc/cups/ppd/tsp143_v2.ppd":
    owner   => root,
    source  => "puppet:///modules/star_tsp143_printer/ppd/star/tsp143_v2.ppd"
  }
}
