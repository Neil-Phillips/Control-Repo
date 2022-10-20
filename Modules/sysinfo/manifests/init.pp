#
class sysinfo inherits sysinfo::params {

  if $_hostname =~ 'till' or $_hostname =~ 'manager'{

    anchor { 'sysinfo::begin': } ->
    class { '::sysinfo::package': } ->
    class { '::sysinfo::config': } ->
    anchor { 'sysinfo::end': }
  }

}

