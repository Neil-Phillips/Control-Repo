#
class epos::config inherits epos {

# Till ID - selector list based on i4, if no match use 4th octet
  $tillid = $i4 ? {
# Old Shops
    '11'    => '1',
    '12'    => '2',
    '13'    => '3',
    '14'    => '4',
    '15'    => '5',
    '16'    => '6',
# New Shops
    '71'    => '1',
    '72'    => '2',
    '73'    => '3',
    '74'    => '4',
    '75'    => '5',
    '76'    => '6',
    default => $i4,
  }

# If the PDQ IP has been set for the host via its parameter, then the IP here will not match the localhost default
if $pdqip != undef {
  $_pdqip = $pdqip
} else {

  $_pdqip = $i4 ? {
# Old Shops
    '11'    => "${net}.151",
    '12'    => "${net}.152",
    '13'    => "${net}.153",
    '14'    => "${net}.154",
    '15'    => "${net}.155",
    '16'    => "${net}.156",
# New Shops
    '71'    => "${net}.130",
    '72'    => "${net}.131",
    '73'    => "${net}.132",
    '74'    => "${net}.133",
    '75'    => "${net}.134",
    '76'    => "${net}.135",
    default => "127.0.0.1",
  }

}

# Settings and PouchDB storage
  file { '/etc/epos/':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { '/etc/epos/settings.json':
    owner    => root,
    group    => root,
    mode     => '0444',
    show_diff => true,
    content => template('epos/settings.json.erb'),
  }

  file { $local_storage:
    ensure => directory,
# This used to be the user id 'toolstation' but some machines are built with different primary login users - e.g. laptops
# so the workaround is to use the numeric id 1001 - which will always resolve to the first user created after 'systems'
    owner  => '1001',
    group  => users,
    mode   => '0755',
  }

  file { $epos_storage:
    ensure => directory,
# Numeric uid used rather than a name - see above for the reason
    owner  => '1001',
    group  => users,
    mode   => '0755',
  }

}
